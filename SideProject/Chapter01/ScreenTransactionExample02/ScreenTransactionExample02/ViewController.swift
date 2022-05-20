//
//  ViewController.swift
//  ScreenTransactionExample02
//
//  Created by 전성규 on 2022/05/11.
//

import UIKit

class ViewController: UIViewController, SendDataDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seguePushViewController = segue.destination as? SeguePushViewController {
            seguePushViewController.name = "Jeon Seong Gyu"
        }
        
        if let seguePresentViewController = segue.destination as? SeguePresentViewController {
            seguePresentViewController.name = "Kim Seong Jae"
        }
    }

    
    @IBAction func tapCodePushButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePushViewController")
                as? CodePushViewController else { return }
        viewController.name = "Lee Min Young"
        viewController.delegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func tapCodePresentButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePresentViewController")
                as? CodePresentViewController else { return }
        viewController.name = "Lee Kie Myung"
        viewController.delegate = self
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sendDate(name: String) {
        self.nameLabel.text = name
        self.nameLabel.sizeToFit()
    }
}

