//
//  WriteDiaryViewController.swift
//  Diary
//
//  Created by 전성규 on 2022/05/09.
//

import UIKit

protocol WriteDiaryViewDelegate: AnyObject {
    func didSelectRegister(diary: Diary)  // 일기가 작성된 Diary 객체를 전달한다.
}

class WriteDiaryViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    
    weak var delegate: WriteDiaryViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuarContentsTextView()
        self.configuarDatePicker()
        self.configuarInputFiedl()
        self.confirmButton.isEnabled = false
    }
    
    @IBAction func tapComfirmButton(_ sender: UIBarButtonItem) {
        guard let title = self.titleTextField.text else {return}
        guard let contents = self.contentTextView.text else {return}
        guard let date = self.diaryDate else {return}
        
        let diary = Diary(title: title, contents: contents, date: date, isStar: false)
        self.delegate?.didSelectRegister(diary: diary)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func configuarContentsTextView() {
        let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        self.contentTextView.layer.borderColor = borderColor.cgColor
        self.contentTextView.layer.borderWidth = 0.5
        self.contentTextView.layer.cornerRadius = 5.0
    }
    
    private func configuarDatePicker() {
        self.datePicker.datePickerMode = .date  // 날짜만 나오도록 설정
        self.datePicker.preferredDatePickerStyle = .wheels
        /*
         addTaget()
         UI Controller 객체가 Event에 응답하는 설정을 해주는 메서드
         첫 번쨰 파라미터는 타겟
         action: 이벤트가 발생하였을 때 그에 응답하여 호출될 메서드를 sleector로 넘겨준다
         for: 어떤 이벤트가 발생했을 때 acction에 정의한 메서드를 호출할 것인가
         */
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        self.datePicker.locale = Locale(identifier: "ko_RR")  // DatePicker 한국어 표시 설정
        self.dateTextField.inputView = self.datePicker
    }
    
    private func configuarInputFiedl() {
        self.contentTextView.delegate = self
        self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        self.dateTextField.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter() // DateFormatter(): 날짜와 텍스트를 변환해주는 역할 ... Date Type을 사람이 읽을 수 있는 형태로 반환, 날짜 형태의 문자열에서 Date Type으로 변환해주는 역할
        formatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"  // EEEEE: 요일을 한 글자만 표현하는 방법
        formatter.locale = Locale(identifier: "ko_KR")  // 한국어 설정
        self.diaryDate = datePicker.date
        self.dateTextField.text = formatter.string(from: datePicker.date)  // Date를 Formatter에서 지정한 문자열로 변경시켜 dateTextField에 표시
        self.dateTextField.sendActions(for: .editingChanged)  // 날짜가 변경될떄마다 editingChanged 메서드가 호출된다
    }
    
    @objc private func titleTextFieldDidChange(_ textField: UITextField) {
        self.validateInputField()
    }
    
    @objc private func dateTextFieldDidChange(_ textField: UITextField) {
        self.validateInputField()
    }
    
    // 등록버튼의 활성화 여부를 판단하는 메서드
    private func validateInputField() {
        self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.dateTextField.text?.isEmpty ?? true) && !(self.contentTextView.text.isEmpty)
    }
}

extension WriteDiaryViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {   // TextView의 Text가 입력될떄마다 호출되는 메서드, 내용이 입력될떄마다 어떤 메서드를 호출해서 등록버튼 활성화 여부를 판단할 수 있게 구현해야 한다.
        self.validateInputField()
    }
}
