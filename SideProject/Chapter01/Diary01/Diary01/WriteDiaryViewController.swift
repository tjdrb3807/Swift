//
//  WriteDiaryViewController.swift
//  Diary01
//
//  Created by 전성규 on 2022/05/12.
//

import UIKit

protocol WriteDiaryViewDelegate: AnyObject {
    func didSelectRegister(diary: Diary)
}

// (15)
enum DiaryEditMode {
    case new
    case edit(IndexPath, Diary)
}

class WriteDiaryViewController: UIViewController {

    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    weak var delegate: WriteDiaryViewDelegate?
    
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    
    var diaryDditMode: DiaryEditMode = .new
    // DiaryEditMode를 통해서 수정할 Diary 객체 전달
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuarContentsTextView()
        self.configuarDatePicker()
        self.confirmButton.isEnabled = false
        self.configuarInputField()
        self.configuarEditMode()
    }
    
    @IBAction func tabConfrimButton(_ sender: UIBarButtonItem) {
        guard let title = self.titleTextView.text else { return }
        guard let contents = self.contentsTextView.text else { return }
        guard let date = self.diaryDate else { return }
//        let diary = Diary(title: title, contents: contents, date: date, isStar: false)
        // (33)
        
        
        // (16)
        switch self.diaryDditMode {
        case .new:
            // (31)
            let diary = Diary(title: title, contents: contents, date: date, isStar: false)
            self.delegate?.didSelectRegister(diary: diary)
            
        case let .edit(indexPaht, /* (33) _*/ diary):
            // (33)
            let diary = Diary(title: title, contents: contents, date: date, isStar: diary.isStar)
            NotificationCenter.default.post(name: NSNotification.Name("editDiary"),
                                            object: diary,
                                            userInfo: [
                                                "indexPath.row": indexPaht.row
                                            ])
        }
//        self.delegate?.didSelectRegister(diary: diary)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // (1) Text Field 테두리 생성
    private func configuarContentsTextView() {
        let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        self.contentsTextView.layer.borderColor = borderColor.cgColor
        self.contentsTextView.layer.borderWidth = 0.5
        self.contentsTextView.layer.cornerRadius = 5.0
    }
    
    // (2) DatePicker 구현
    private func configuarDatePicker() {
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.locale = Locale(identifier: "ko_KR")
        self.datePicker.addTarget(self,
                                  action: #selector(datePickerValueDidChange(_ :)),
                                  for: .valueChanged)
        self.dateTextField.inputView = self.datePicker
    }
    
    // (3) 빈 화면 Tap -> Keyboard, DatePicker 사라짐 기능 구현
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // (4) 모든 내용 작성시 등록 버튼 활설와 기능 구현
    private func configuarInputField() {
        self.contentsTextView.delegate = self
        self.titleTextView.addTarget(self,
                                     action: #selector(titleTextViewDidChange(_:)),
                                     for: .editingChanged)
        self.dateTextField.addTarget(self,
                                     action: #selector(dateTextFiedlDidChange(_:)),
                                     for: .editingChanged)
    }
    
    private func validadteInputField() {
        self.confirmButton.isEnabled = !(self.titleTextView.text?.isEmpty ?? true) && !(self.dateTextField.text?.isEmpty ?? true) && !self.contentsTextView.text.isEmpty
    }
    
    // (15)
    private func configuarEditMode() {
        switch self.diaryDditMode {
        case let .edit(_, diary):
            self.titleTextView.text = diary.title
            self.contentsTextView.text = diary.contents
            self.dateTextField.text = dateToString(date: diary.date)
            self.diaryDate = diary.date
            self.confirmButton.title = "수정"
            
        default:
            break
        }
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formmater.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        self.dateTextField.text = formmater.string(from: datePicker.date)
        //(5)
        self.dateTextField.sendActions(for: .editingChanged)
    }
    
    @objc private func titleTextViewDidChange(_ textField: UITextField) {
        self.validadteInputField()
    }
    
    @objc private func dateTextFiedlDidChange(_ TextField: UITextField) {
        self.validadteInputField()
    }
}

extension WriteDiaryViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.validadteInputField()
    }
}
