//
//  ViewController.swift
//  ScreenTransactionExample
//
//  Created by 전성규 on 2022/05/07.
//

import UIKit

class ViewController: UIViewController, SendDataDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController 뷰가 로드 되었다.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController 뷰가 나타날 것이다.")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewController 뷰가 나타났다.")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController 뷰가 사라질 것이다.")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ViewController 뷰가 사라졌다.")
    }
    
    @IBAction func tapCodePushButton(_ sender: UIButton) {
        
        // Navigation Stack에  CodePushViewController가 Push
        
        // Storyboard에 있는 ViewController를 인스턴스화
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePushViewController") as? CodePushViewController else {return}
        /* 전환되는 View 화면의 Class Type으로 다운캐스팅
           각 타입에 맞는 Class Type으로 다운캐스팅을 하게되면, 각 ViewController의 main Property에 접근할 수 있다.
           그러면 다른화면으로 Push나 Present 되기전에 main 프로퍼티에 값을 넘겨주면 전환된 화면으로 데이터를 전달할 수 있다.
         */
        viewController.name = "전성규"
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func tapCodePresentButton(_ sender: UIButton) {
        
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePresentViewController") as?  CodePresentViewController else {return}
        
        // default는 Modal
        // 전체 화면으로 변경
        viewController.modalPresentationStyle = .fullScreen
        viewController.name = "김성재"
        viewController.delegate = self
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewContoller = segue.destination as? SeguePushViewController {
            viewContoller.name = "전성규"
        }
    }
    
    func sendData(name: String) {
        self.nameLabel.text = name
        self.nameLabel.sizeToFit()
    }
}

