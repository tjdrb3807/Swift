//
//  WriteDiaryViewController.swift
//  Diary02
//
//  Created by 전성규 on 2022/05/13.
//

import UIKit

protocol WriteDiaryViewDelegate: AnyObject {
    func didSelectRegister(diary: Diary)
}

class WriteDiaryViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    weak var deleget: WriteDiaryViewDelegate?
    
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.confirmButton.isEnabled = false
        self.configuarContnetsTextView()
        self.configuarDatePicker()
        self.configuarInputField()
    }
    
    // 빈 화면 Tap -> Keyboard, DatePicker 사라짐 설정
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func tapConfirmButton(_ sender: UIBarButtonItem) {
        guard let title = self.titleTextField.text else { return }
        guard let contents = self.contentsTextView.text else { return }
        guard let date = self.diaryDate else { return }
        
        let diary = Diary(title: title, contents: contents, date: date, isStar: false)
        self.deleget?.didSelectRegister(diary: diary)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // Text Field 테두리 설정
    private func configuarContnetsTextView() {
        let boraderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        self.contentsTextView.layer.borderColor = boraderColor.cgColor
        self.contentsTextView.layer.borderWidth = 0.5
        self.contentsTextView.layer.cornerRadius = 5.0
    }
    
    // DatePicker 설정
    private func configuarDatePicker() {
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self,
                                  action: #selector(datePickerValueDidChange(_:)),
                                  for: .valueChanged)
        self.dateTextField.inputView = self.datePicker
    }
    
    // 모든 내용 작성시 등록 버튼 활성화 기능 구현
    private func configuarInputField() {
        self.contentsTextView.delegate = self
        self.titleTextField.addTarget(self,
                                      action: #selector(titleTextFieldDidChange(_:)),
                                      for: .editingChanged)
        self.dateTextField.addTarget(self,
                                     action: #selector(dateTextFieldDidChange(_:)),
                                     for: .editingChanged)
    }
    
    private func validateInputField() {
        self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.dateTextField.text?.isEmpty ?? true) && !self.contentsTextView.text.isEmpty
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        self.dateTextField.text = formatter.string(from: datePicker.date)
        self.dateTextField.sendActions(for: .editingChanged)
    }
    
    @objc private func titleTextFieldDidChange(_ textField: UITextField) {
        self.validateInputField()
    }
    
    @objc private func dateTextFieldDidChange(_ dateField: UITextField) {
        self.validateInputField()
    }
}

extension WriteDiaryViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
    }
}

