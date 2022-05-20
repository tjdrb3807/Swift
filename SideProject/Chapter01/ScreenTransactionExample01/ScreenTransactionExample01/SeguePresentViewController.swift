//
//  SeguePresentViewController.swift
//  ScreenTransactionExample01
//
//  Created by 전성규 on 2022/05/11.
//

import UIKit

class SeguePresentViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapXMark(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
