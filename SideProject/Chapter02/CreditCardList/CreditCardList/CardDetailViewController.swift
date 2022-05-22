//
//  CardDetailViewController.swift
//  CreditCardList
//
//  Created by 전성규 on 2022/05/20.
//

import UIKit
import Lottie

class CardDetailViewController: UIViewController {

    @IBOutlet weak var lottieView: AnimationView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var bnenfitConditionLabel: UILabel!
    @IBOutlet weak var benefitDetailLabel: UILabel!
    @IBOutlet weak var benefitDateLabel: UILabel!
    
    var promotionDetail: PromotionDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // money Lottie Animation 구현
        let animationView = AnimationView(name: "money") //Lottie가 가져올 JSON 파일명을 파라미터로 넘겨준다.
        lottiaeView.contentMode = .scaleAspectFill
        lottieView.addSubview(animationView)
        animationView.frame = lottieView.bounds
        animationView.loopMode = .loop //단순 반복
        animationView.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let detail = promotionDetail else { return }
        
        titleLabel.text = """
        \(detail.companyName)카드 쓰면
        \(detail.amount)만원 드려요.
        """
        
        periodLabel.text = detail.period
        conditionLabel.text = detail.condition
        bnenfitConditionLabel.text = detail.benefitCondition
        benefitDateLabel.text = detail.benefitDetail
        benefitDetailLabel.text = detail.benefitDate
    }
}
