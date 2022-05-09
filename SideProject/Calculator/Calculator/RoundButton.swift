//
//  RoundButton.swift
//  Calculator
//
//  Created by 전성규 on 2022/05/09.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var isRound: Bool = false {
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
}
