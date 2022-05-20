//
//  CodePresentViewController.swift
//  ScreenTransactionExample01
//
//  Created by 전성규 on 2022/05/11.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func sendData(name: String)
}

class CodePresentViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    // Delegate 변수를 선언하므로서 위임할 준비를 마췄다
    weak var delegate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name {
            self.nameLabel.text = name
        }
    }
    
    @IBAction func tabBackButton(_ sender: UIButton) {
        // 데이터를 전달받은 ViewController에서 SendDateDelegate Protocol을 채택하고 delegate를 위임받게 되면 sendDate 함수가 실행
        self.delegate?.sendData(name: "Kim Seong Jae")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
