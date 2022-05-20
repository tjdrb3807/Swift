//
//  EmailViewController.swift
//  SpotifyStyleLoginSampleApp
//
//  Created by 전성규 on 2022/05/19.
//

import UIKit
import FirebaseAuth

class EmailViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 30
        nextButton.isEnabled = false
        
        //(기능 01)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        //(기능 02)
        emailTextField.becomeFirstResponder()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Navigation Bar 표시
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        //(기능 03)
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        //신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007:  //이미 가입한 계정일 떄
                    //(기능03_03)
                    self.loginUser(withEmail: email, password: password)
                    
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
            } else {
                //(기능03-01)
                self.showMainViewController()
            }
        }
    }
    
    private func showMainViewController() {
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let mainViewController = self.storyboard?.instantiateViewController(identifier: "MainViewController") else { return }
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
    
    private func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
}

extension EmailViewController: UITextFieldDelegate {
    //(기능 01_01)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        return false
    }
    
    //(기능 02_02)
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        
        nextButton.isEnabled = !isEmailEmpty && isPasswordEmpty
    }
}
