//
//  SeguePresentViewController.swift
//  ScreenTransactionExample
//
//  Created by 전성규 on 2022/05/07.
//

import UIKit

class SeguePresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
