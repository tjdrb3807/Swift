//
//  MainViewController.swift
//  SpotifyStyleLoginSampleApp
//
//  Created by 전성규 on 2022/05/19.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //PopGestuer 기능 삭제
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Navigagion Bar 숨김
        navigationController?.navigationBar.isHidden = true
        
        //(기능03_02)
        let email = Auth.auth().currentUser?.email ?? "고객"
        welcomeLabel.text = """
        환영합니다.
        \(email)님
        """
    }
    @IBAction func tapLogoutButton(_ sender: UIButton) {
        //(기능03_04)
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            //error가 발생하지 않을 경우 pop
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            //error가 발생한 경우
            print("ERROR: singout \(signOutError.localizedDescription)")
        }
    }
}
