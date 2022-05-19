//
//  EmailViewController.swift
//  SpotifyStyleLoginSampleApp
//
//  Created by 전성규 on 2022/05/19.
//

import UIKit

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
    }
}

extension EmailViewController: UITextFieldDelegate {
    //(기능 01_01)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        return false
    }
    
    //(기능 02_02_
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        
        nextButton.isEnabled = !isEmailEmpty && isPasswordEmpty
    }
}
