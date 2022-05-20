//
//  EnterEmailViewController.swift
//  SpotifyStyleLoginAppExample
//
//  Created by 전성규 on 2022/05/20.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 30     //NextButton Layer 설정
        nextButton.isEnabled = false           //NextButton 초기 설정
        emailTextField.becomeFirstResponder()  //emailTextField 초기 Focus 설정
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Navigation Bar 표시
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        
    }
}

extension EnterEmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        <#code#>
    }
    
}
