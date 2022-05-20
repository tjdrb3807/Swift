//
//  SettingViewController.swift
//  LEDBoard02
//
//  Created by 전성규 on 2022/05/12.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func settingLEDBoard(text: String?, textColor: UIColor, backgroundColor: UIColor)
}

class SettingViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    
    weak var deleaget: SendDataDelegate?
    
    var text: String?
    var textColor:UIColor = .yellow
    var backgroundColor:UIColor = .black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuarView()
    }
    
    @IBAction func tapTextColorButton(_ sender: UIButton) {
        if sender == self.yellowButton {
            self.changeTextColor(color: UIColor.yellow)
            self.textColor = UIColor.yellow
        } else if sender == self.purpleButton {
            self.changeTextColor(color: UIColor.purple)
            self.textColor = UIColor.purple
        } else {
            self.changeTextColor(color: UIColor.green)
            self.textColor = UIColor.green
        }
    }
    
    @IBAction func tapBackgroundButton(_ sender: UIButton) {
        if sender == self.blackButton {
            self.changeBackgroundColor(color: UIColor.black)
            self.backgroundColor = UIColor.black
        } else if sender == self.blueButton {
            self.changeBackgroundColor(color: UIColor.blue)
            self.backgroundColor = UIColor.blue
        } else {
            self.changeBackgroundColor(color: UIColor.orange)
            self.backgroundColor = UIColor.orange
        }
    }
    
    @IBAction func tapSaveButton(_ sender: UIButton) {
        self.deleaget?.settingLEDBoard(text: self.textField.text, textColor: self.textColor, backgroundColor: self.backgroundColor)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    private func changeTextColor(color: UIColor) {
        self.yellowButton.alpha = color == UIColor.yellow ? 1 : 0.2
        self.purpleButton.alpha = color == UIColor.purple ? 1 : 0.2
        self.greenButton.alpha = color == UIColor.green ? 1 : 0.2
    }
    
    private func changeBackgroundColor(color: UIColor) {
        self.blackButton.alpha = color == UIColor.black ? 1 : 0.2
        self.blueButton.alpha = color == UIColor.blue ? 1 : 0.2
        self.orangeButton.alpha = color == UIColor.orange ? 1 : 0.2
    }
    
    private func configuarView() {
        if let text = text {
            self.textField.text = text
        }
        self.changeTextColor(color: textColor)
        self.changeBackgroundColor(color: backgroundColor)
    }
}
