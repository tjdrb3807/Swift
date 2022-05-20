//
//  LoginViewController.swift
//  SpotifyStyleLoginAppExample
//
//  Created by 전성규 on 2022/05/20.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {

    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailLoginButton, googleLoginButton, appleLoginButton] .forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true //Navigation Bar 숨기
        
    }
    
    @IBAction func tapEmailLoginButton(_ sender: UIButton) {
    }
    
    @IBAction func tapGoogleLoginButton(_ sender: UIButton) {
    }
    
    @IBAction func tapAppleLoginButton(_ sender: UIButton) {
    }
}
