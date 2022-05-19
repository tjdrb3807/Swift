//
//  MainViewController.swift
//  SpotifyStyleLoginSampleApp
//
//  Created by 전성규 on 2022/05/19.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //PopGestuer 기능 삭제
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Navigagion Bar 숨김
        navigationController?.navigationBar.isHidden = true
    }
    @IBAction func tapLogoutButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
