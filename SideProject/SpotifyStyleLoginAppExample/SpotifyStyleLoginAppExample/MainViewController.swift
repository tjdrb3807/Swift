//
//  MainViewController.swift
//  SpotifyStyleLoginAppExample
//
//  Created by 전성규 on 2022/05/20.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Pop Gesture 기능 삭제
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Navigation Bar 숨기
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func tapLogoutButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
