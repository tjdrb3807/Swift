//
//  MainViewController.swift
//  SpotifyStyleLoginAppExample
//
//  Created by 전성규 on 2022/05/20.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false   //Pop Gesture 기능 삭제
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true   //Navigation Bar 숨기
        
        let email = Auth.auth().currentUser?.email ?? "고객"
        welcomeLabel.text = """
        환영합니다.
        \(email)님
        """
    }
    
    @IBAction func tapLogoutButton(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)  //error가 발생하지 않은 경우 실행
        } catch let signOutError as NSError {
            print("ERROR: signOut \(signOutError.localizedDescription)")
        }
            
    }
}
