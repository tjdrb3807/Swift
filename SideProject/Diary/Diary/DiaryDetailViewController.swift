//
//  DiaryDetailViewController.swift
//  Diary
//
//  Created by 전성규 on 2022/05/09.
//

import UIKit

// 작업(6): 일기 삭제시 일기장 목록에서 일기 제거 기능 구현
// delegate를 통해서 일기장 상세 화면에서 삭제가 일어날 때 메서드를 통해 인기장 리스트 화면에 indexPath를 전달하여 바이너리 리스트 배열와 CollectionVeiw의 일기가 삭제되는 기능 구현
// 추구 즐겨찾기 구현시 이 delegate는 삭제
protocol DiaryDetailViewDelegate: AnyObject {
    func didSelectDelte(indexPath: IndexPath)
    // 다음 작업(7) -> 프로퍼터 설정
    // 작업(25)
    func didSelectStar(indexPaht: IndexPath, isStar: Bool)
    // 다음 작업(26) -> tapStarButton 함수
}

class DiaryDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTectView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    // 작업(7)
    weak var delegate: DiaryDetailViewDelegate?
    // 다음 작업(8) -> DiaryDetilViewController.tapDeletButton에서 기능 구현
    
    // 작업(1): 일기장 리스트 화면에서 데이터를 전달받을 프로퍼티 설정
    var diary: Diary?
    var indexPath: IndexPath?
    // 다음 작업: (2)
    
    // 작업(22)
    var starButton: UIBarButtonItem?
    // 다음 작업(23) -> DiaryDetailViewController.configuarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 작업(4)
        self.configureView()
        // 다음 작업: 일기장 리스트 화면에서 일기를 선택하였을 때 일기 상세 화면으로 이동
        // storyboard에서 DiaryDetaliViewController의 stroyboadr id를 DiaryDelailViewController로 설정
        // ViewController 에서 extention 작업(5) 구현
    }
    
    // 작업(19)
    @objc func editDiaryNotification(_ notification: Notification) {
        // 수정된 diary객체를 전달받아 view에 update 되도록 기능 구현
        // Post Method에서 보낸 수정된 diary객체를 가져오는 코드 작성
        guard let diary = notification.object as? Diary else {return}
        // Post할 떄 UserInfo에 indexPath.row값을 dictionary로 보낸것을 가져오는 코드
        guard let row = notification.userInfo?["indexPath.row"] as? Int else {return}
        self.diary = diary
        self.configureView()
        // 다음 작업(20) deInit
    }
    
    // 작업(24)
    @objc func tapStarButton() {
        guard let isStar = self.diary?.isStar else {return}
        // 작업(26)
        guard let indexPath = self.indexPath else {return}

        if isStar {
            self.starButton?.image = UIImage(systemName: "star")
        } else {
            self.starButton?.image = UIImage(systemName: "star.fill")
        }
        // 작업(26)
        self.delegate?.didSelectStar(indexPaht: indexPath , isStar: self.diary?.isStar ?? false)
        // 다음 작업(27) -> extension ViewController: DiaryDetilViewController didSelectStar 메서드 구현
        self.diary?.isStar = !isStar
        // 다음 작업(25): 일기장 상세 화면에서 즐겨찾기를 눌렀을 떄 즐겨찾기 상태를 일기장 리스트에 전달 기능 구현
        // DiaryDetailViewController portocol에 메서드 정의
    }
    
    private func configureView() {
        // 작업(2): 프로퍼티로 받은 diary를 view에 초기화
        guard let diary = self.diary else {return}
        self.titleLabel.text = diary.title
        self.contentsTectView.text = diary.contents
        // diary 인스턴스의 date 프로퍼티는 Date Type 이므로 DateFormatter를 사용해서 문자로 변환
        // 다음 작업: (3)
        self.dateLabel.text = self.dateToString(date: diary.date)
        // 다음 작업: (4)
        // 작업(23)
        self.starButton = UIBarButtonItem(image: nil,
                                          style: .plain,
                                          target: self,
                                          action: #selector(tapStarButton)) // 버튼을 눌렀을 때 호출되는 selector 메서드
        self.starButton?.image = diary.isStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        self.starButton?.tintColor = .orange
        self.navigationItem.rightBarButtonItem = self.starButton
        // 다음 작업(24) tapStarButton
    }
    
    // 작업(3)
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM원 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter.string(from: date)
    }
    // 다음 작업: 작업(2) 마무리
    
    @IBAction func tapEditButton(_ sender: UIButton) {
        // 작업(11)
        // 수정 버튼이 눌리면 WriteDiaryViewController가 Push되는 기능 구현
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "WriteDiaryViewController") as? WriteDiaryViewController else {return}
        self.navigationController?.pushViewController(viewController, animated: true)
        // 다음 작업(12) -> WriteDiaryViweController 열거형 프로퍼티 추가
        
        // 작업(14)
        guard let indexPath = self.indexPath else {return}
        guard let diary = self.diary else {return}
        viewController.diaryEditorMode = .edit(indexPath, diary)
        // 다음 작업(15): 연관값으로 전달받은 다이어리 객체를 WriteDiaryViewController에 TextView, TextField에 표시되게하는 기능 구현
        // WriteDiaryViewController 메서드 정의
        
        // 작업(18): Notification을 Observing하는 코드 작성
        // "editDiary" Notification을 Observing
        // Observer를 추가하게되면 특정 이름의 Notification의 Event가 발생하였는지 계속 관찰한다.
        // 특정한 Event가 발생하면 특정 행위를 수행한다.
        // 첫 번째 파라미터: Observing할 인스턴스를 넘겨준다
        // selector: #selector 함수를 넘겨준다, Notification을 탐지하고있다가 Event가 발생하면 Selector에 정의한 함수가 호출된다.
        // name: 관찰할 Notification 이름을 넘겨준다
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification(_:)),
            // 다음 작업(19): selector함수 정의
            name: NSNotification.Name("editDiary"),
            object: nil
        )
        // 수정 버튼을 눌렀을 때 "editDiary" Notification을 관찰하느 Observer가 추가되며, WriteDiaryViewController에서 수정된 diary 객체가 NotificationCenter를 통해서 Post될 떄 editDiaryNotification 메서드가 호출된다.
    }
    
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        // 작업(8)
        guard let indexPath = self.indexPath else {return}
        self.delegate?.didSelectDelte(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
        // 다음 작업(9) -> extension ViewController: UICollectionViewDelegate 에서 기능 추가
        
    }
    
    // 작업(20): 해당 인스턴스에 추가된 Observer 모두 제거
    // 관찰이 필요 없을때는 removeObserver Method를 이용해서 Observer를 제거할 수 있다.
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    // 다음 작업(21): 일기장리스트 화면에도 Notification Observer를 추가해서 수정이 발생하면 일기장 리스트 화면도 수정된 내용으로 변경되게 구현
    // ViewController.viewDidLoad
}
