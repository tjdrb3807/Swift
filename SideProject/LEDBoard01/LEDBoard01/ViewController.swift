//
//  ViewController.swift
//  LEDBoard01
//
//  Created by 전성규 on 2022/05/12.
//

import UIKit

class ViewController: UIViewController, SendDataDelegate {

    @IBOutlet weak var contentsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentsLabel.textColor = .yellow
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingViewController = segue.destination as? SettingViewController {
            settingViewController.delegate = self
            settingViewController.textField = self.contentsLabel.text
            settingViewController.textColor = self.contentsLabel.textColor
            settingViewController.backgroundColor = self.view.backgroundColor ?? .black
        }
    }
    
    func sendData(content: String?, textColor: UIColor, backgroundColor: UIColor) {
        if let content = content {
            self.contentsLabel.text = content
        }
        self.contentsLabel.textColor = textColor
        self.view.backgroundColor = backgroundColor
    }
}

