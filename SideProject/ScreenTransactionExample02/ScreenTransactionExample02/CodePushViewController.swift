//
//  CodePushViewController.swift
//  ScreenTransactionExample02
//
//  Created by 전성규 on 2022/05/11.
//

import UIKit

class CodePushViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    weak var delegate: SendDataDelegate?
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name {
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.delegate?.sendDate(name: "Lee Min Young")
        self.navigationController?.popViewController(animated: true)
    }
}
