//
//  WriteDiaryViewController.swift
//  Diary
//
//  Created by 전성규 on 2022/05/09.
//

import UIKit

// 작업(12)
enum DiaryEditorMode {
    case new
    case edit(IndexPath, Diary)
}
// 다음 작업(13)

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
    
    // 작업(13)
    // DiartEditorMode 를 저장하는 프로퍼티 설정
    var diaryEditorMode: DiaryEditorMode = .new
    // 다음 작업(14): diaryEditorMode 프로퍼티를 통해서 수정한 다이어리 객체 전달 기능 구현
    // DiaryDetailViewController.tapEditButton Action 함수에 기능 추가
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuarContentsTextView()
        self.configuarDatePicker()
        self.configuarInputFiedl()
        self.confirmButton.isEnabled = false
        // 작업(16)
        self.configuarEditMode()
        // 다음 작업(17) 수정된 내용이 DiaryDetailViewController에도 적용되는 기능 구현
        // tapComfirmButton에 기능 추가
    }
    
    @IBAction func tapComfirmButton(_ sender: UIBarButtonItem) {
        guard let title = self.titleTextField.text else {return}
        guard let contents = self.contentTextView.text else {return}
        guard let date = self.diaryDate else {return}
        
        let diary = Diary(title: title, contents: contents, date: date, isStar: false)
        
        // 기능(17): 수정된 내용을 전달하는 notificationCenter 구현
        // notificationCenter를 이용해서 수정이 일어나면 notificationCenter에 수정된 diary 객체를 전달하고 notificationCenter를 구독하고 있는 화면에서 수정된 Diary객체를 전달받아 view 에도 수정된 내용이 갱신되게 구현
        // notificationCenter: 등록된 이벤트가 발생하면 해당 이벤트들에 대한 행동을 취한다
        // 앱 내에 아무곳에서나 메세지를 던지면 앱 내의 아무곳에서나 이 메세지를 받을 수 있게 해주는 것이다.
        // eventBus라 생각하면 된다.
        // event는 Post라는 메서드를 이용해서 이벤트를 전송하고 이벤트를 받으려면 옴저버를 등록해서 Post한 이벤트를 전달받을 수 있다.
        // Notification Center의 Post 메서드를 이용해서 일기 내용이 수정된 객체를 Notification Center의 Observing 하는 곳에 전달하도록 코드 작성
        // 수정버튼을 누르면 Post 메서드를 호출하는 기능 구현
        switch self.diaryEditorMode {
        case .new:  // 일기를 등록하는 행위를 해야한다.
            self.delegate?.didSelectRegister(diary: diary)
        case let .edit(indexPath, _): // 일기를 수정하는 행위를 해야한다.
            // NotificationCenter의 Post Method를 이용해서 수정된 Diary 객체를 전달하는 기능 구현
            // nema parameter에는 Notification의 이름을 적어준다.
            // 이 이름을 가지고 Observer에서 설정한 이름에 Notification Event가 발생하였는지 관찰하게 된다.
            // object에는 NotificationCenter를 통해 전달할 객체를 넘겨준다
            // userInfo에는 Notification과 관련된 값을 넘겨준다.
            NotificationCenter.default.post(
                name: NSNotification.Name("editDiary"),
                object: diary,  // 수정된 내용의 diary 객체
                userInfo: [ // 수정이 발생하면 CollectionView List에도 수정이 일어나야한다.
                    "indexPath.row": indexPath.row
                ])  // 수정 버튼을 누르게 되면 NotificationCenter가 "editDiary"라는 Notification Key를 Observing하는 곳에 수정된 diary객체를 전달하게 된다
        }
        // 다음 작업(18): 일기장 상세 화면에서 Notification을 Observing하고 수정이 방생했을 떄 수정된 일기장 내용으로 view가 없데이트 되게 기능 구현
        // DiaryDetailViewController.tapEditButton에 기능 추가
//        self.delegate?.didSelectRegister(diary: diary) switch문으로 변경
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
    
    // 작업(15)
    private func configuarEditMode() {
        switch self.diaryEditorMode {
            case let .edit(_, diray):
                self.titleTextField.text = diray.title
                self.contentTextView.text = diray.contents
                self.dateTextField.text = self.dateToString(date: diray.date)
                self.diaryDate = diray.date
                self.confirmButton.title = "수정"
            
        default:
            break
        }
    }
    // 작업(16) -> viewDidLoad
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "kr_KO")
        
        return formatter.string(from: date)
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
