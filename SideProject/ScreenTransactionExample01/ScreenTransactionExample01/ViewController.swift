//
//  ViewController.swift
//  ScreenTransactionExample01
//
//  Created by 전성규 on 2022/05/11.
//

import UIKit

class ViewController: UIViewController, SendDataDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Navigation Stack에 CodePushViewController가 Push 기능 구현
    @IBAction func tapCodePushButton(_ sender: UIButton) {
        // CodePushViewController 인스턴스화
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePushViewController") as? CodePushViewController else { return }
        
        viewController.name = "Jeon Seong Gyu"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func tabCodePresentButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePresentViewController") as? CodePresentViewController else { return }
        
        viewController.modalPresentationStyle = .fullScreen
        viewController.name = "Lee Min Young"
        // delegate 위임받기
        viewController.delegate = self
        self.present(viewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SeguePushViewController {
            viewController.name = "Jeon Seong Gyu"
        }
    }
    
    func sendData(name: String) {
        self.nameLabel.text = name
        self.nameLabel.sizeToFit()
    }
}

