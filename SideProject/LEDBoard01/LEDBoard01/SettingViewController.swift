//
//  SettingViewController.swift
//  LEDBoard01
//
//  Created by 전성규 on 2022/05/12.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func sendData(content: String?, textColor: UIColor, backgroundColor: UIColor)
}

class SettingViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    
    weak var delegate: SendDataDelegate?
    
    var contents: String?
    var textColor = UIColor.yellow
    var backgroundColor = UIColor.black
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapTextColorButton(_ sender: UIButton) {
        if sender == self.yellowButton {
            changeTextColor(color: .yellow)
            self.textColor = .yellow
        } else if sender == self.purpleButton {
            changeTextColor(color: .purple)
            self.textColor = .purple
        } else{
            changeTextColor(color: .green)
            self.textColor = .green
        }
    }
    
    @IBAction func tapBackgroundButton(_ sender: UIButton) {
        if sender == self.blackButton {
            changeBackgroundColor(color: .black)
            self.backgroundColor = .black
        } else if sender == self.blueButton {
            changeBackgroundColor(color: .blue)
            self.backgroundColor = .blue
        } else {
            changeBackgroundColor(color: .orange)
            self.backgroundColor = .orange
        }
    }
    
    @IBAction func tapSaveButton(_ sender: UIButton) {
        self.delegate?.sendData(content: self.contents, textColor: self.textColor, backgroundColor: self.backgroundColor)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func changeTextColor(color: UIColor) {
        self.yellowButton.alpha = color == .yellow ? 1 : 0.2
        self.purpleButton.alpha = color == .purple ? 1 : 0.2
        self.greenButton.alpha = color == .green ? 1 : 0.2
    }
    
    private func changeBackgroundColor(color: UIColor) {
        self.blackButton.alpha = color == .black ? 1 : 0.2
        self.blueButton.alpha = color == .blue ? 1 : 0.2
        self.orangeButton.alpha = color == .orange ? 1 : 0.2
    }
    
    private func configuarCode() {
        if let contents = contents {
            self.textField.text = contents
        }
        self.changeTextColor(color: self.textColor)
        self.changeBackgroundColor(color: self.backgroundColor)
    }
}
