//
//  DiaryDetailViewController.swift
//  Diary02
//
//  Created by 전성규 on 2022/05/13.
//

import UIKit

class DiaryDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateTextField: UILabel!
    
    var diary: Diary?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapEdtiButton(_ sender: UIButton) {
        
    }
    
    @IBAction func tapDeletButton(_ sender: UIButton) {
        
    }
    
    // 일기장 화면에서 일기 상세 화면으로 기능 구현
    private func configuarView() {
        guard let diary = diary else { return }
        self.titleLabel.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateTextField.text = self.dateToString(date: diary.date)
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter.string(from: date)
    }
}
