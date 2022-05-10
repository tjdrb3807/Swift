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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 작업(4)
        self.configureView()
        // 다음 작업: 일기장 리스트 화면에서 일기를 선택하였을 때 일기 상세 화면으로 이동
        // storyboard에서 DiaryDetaliViewController의 stroyboadr id를 DiaryDelailViewController로 설정
        // ViewController 에서 extention 작업(5) 구현
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
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "WriteDiaryViewController") else {return}
        self.navigationController?.pushViewController(viewController, animated: true)
        // 다음 작업(12) -> WriteDiaryViweController 열거형 프로퍼티 추가
        // 작업(14)
        guard let indexPath = self.indexPath else {return}
        guard let diary = self.diary else {return}
        viewController.diaryEditorMode = .edit(indexPath, diary)
    }
    
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        // 작업(8)
        guard let indexPath = self.indexPath else {return}
        self.delegate?.didSelectDelte(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
        // 다음 작업(9) -> extension ViewController: UICollectionViewDelegate 에서 기능 추가
    }
}
