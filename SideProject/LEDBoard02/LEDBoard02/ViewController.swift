//
//  ViewController.swift
//  LEDBoard02
//
//  Created by 전성규 on 2022/05/12.
//

import UIKit

class ViewController: UIViewController, SendDataDelegate {

    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingViewController = segue.destination as? SettingViewController {
            settingViewController.deleaget = self
            settingViewController.text = self.textLabel.text
            settingViewController.textColor = self.textLabel.textColor
            settingViewController.backgroundColor = self.view.backgroundColor ?? .black
        }
    }
    
    func settingLEDBoard(text: String?, textColor: UIColor, backgroundColor: UIColor) {
        if let text = text {
            self.textLabel.text = text
        }
        self.textLabel.textColor = textColor
        self.view.backgroundColor = backgroundColor
    }
}

