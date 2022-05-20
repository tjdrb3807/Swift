//
//  LoginViewController.swift
//  SpotifyStyleLoginAppExample
//
//  Created by 전성규 on 2022/05/20.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emialLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Button Layer 설정
        [emialLoginButton, googleLoginButton, appleLoginButton] .forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 3.0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Navigation Bar 숨김
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func tapEmailLoginButton(_ sender: UIButton) {
    }
    
    @IBAction func tapGoogleLoginButton(_ sender: UIButton) {
    }
    
    @IBAction func tapAppleLoginButton(_ sender: UIButton) {
    }
}
