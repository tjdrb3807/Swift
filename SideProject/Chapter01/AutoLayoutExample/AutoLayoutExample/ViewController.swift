//
//  ViewController.swift
//  AutoLayoutExample
//
//  Created by 전성규 on 2022/05/07.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var colorVice: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapChangeColorButton(_ sender: UIButton) {
        self.colorVice.backgroundColor = UIColor.blue
        print("색상 변경 버튼이 눌림")
    }
}

