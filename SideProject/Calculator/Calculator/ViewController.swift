//
//  ViewController.swift
//  Calculator
//
//  Created by 전성규 on 2022/05/09.
//

import UIKit

enum Operation {
    case Add
    case Subtract
    case Divide
    case Multifly
    case unkonwn
}

class ViewController: UIViewController {

    @IBOutlet weak var numberOutputLabel: UILabel!
    
    var displayNumber = ""
    var firstOperand = ""
    var secondOperand = ""
    var result = ""
    var currentOperation: Operation = .unkonwn
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tapNumberButton(_ sender: UIButton) {
        guard let numberValue = sender.title(for: .normal) else {return}
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.numberOutputLabel.text = self.displayNumber
        }
    }
    
    @IBAction func tapClearButton(_ sender: UIButton) {
        self.displayNumber = ""
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOperation = .unkonwn
        self.numberOutputLabel.text = "0"
    }
    
    @IBAction func tapDotButton(_ sender: UIButton) {
        // 소수점 포함 9자리까지만 표시될 수 있도록 예외처리
        if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.numberOutputLabel.text = self.displayNumber 
        }
    }
    
    @IBAction func tapDiviedButton(_ sender: UIButton) {
        self.operation(.Divide)
    }
    
    @IBAction func tapMultifplyButton(_ sender: UIButton) {
        self.operation(.Multifly)
    }
    
    @IBAction func tpaSubtractButton(_ sender: UIButton) {
        self.operation(.Subtract)
    }
    
    @IBAction func tapAddButton(_ sender: UIButton) {
        self.operation(.Add)
    }
    
    @IBAction func tapEqualButton(_ sender: UIButton) {
        self.operation(self.currentOperation)
    }
    
    func operation(_ operation: Operation) {
        if self.currentOperation != .unkonwn {
            if !self.displayNumber.isEmpty {
                self.secondOperand = self.displayNumber
                self.displayNumber = ""
                
                guard let firstOperand = Double(self.firstOperand) else {return}
                guard let secondOperand = Double(self.secondOperand) else {return}
                
                switch self.currentOperation {
                case .Add:
                    self.result = "\(firstOperand + secondOperand)"
                    
                case .Subtract:
                    self.result = "\(firstOperand - secondOperand)"
                    
                case .Multifly:
                    self.result = "\(firstOperand * secondOperand)"
                    
                case .Divide:
                    self.result = "\(firstOperand / secondOperand)"
                    
                default:
                    break
                }
                
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                
                self.firstOperand = self.result
                self.numberOutputLabel.text = self.result
            }
            self.currentOperation = operation
            
        } else {
            self.firstOperand = self.displayNumber
            self.currentOperation = operation
            self.displayNumber = ""
        }
    }
}

