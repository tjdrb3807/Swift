//
//  LoginViewController.swift
//  SpotifyStyleLoginSampleApp
//
//  Created by 전성규 on 2022/05/19.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [emailLoginButton, googleLoginButton, appleLoginButton].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Navigation Bar 숨김
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func tapGoogleLoginButton(_ sender: UIButton) {
        //TODO: Firebase Authentication
    }
    
    @IBAction func tapAppleLoginButton(_ sender: UIButton) {
        //TODO: Firebase Authentication
    }
}
