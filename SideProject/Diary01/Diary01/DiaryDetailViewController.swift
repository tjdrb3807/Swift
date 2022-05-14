//
//  DiaryDetailViewController.swift
//  Diary01
//
//  Created by 전성규 on 2022/05/12.
//

import UIKit

protocol DiaryDetailViewDelegate: AnyObject {
    func didSelectDelete(indexPath: IndexPath)
}

class DiaryDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    weak var delegate: DiaryDetailViewDelegate?
    
    var diary: Diary?
    var indexPaht: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuarView()
    }
    
    // (12)
    private func configuarView() {
        guard let diary = diary else { return }
        self.titleLabel.text = diary.title
        self.contentTextView.text = diary.contents
        self.dateLabel.text = dateToString(date: diary.date)
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    // (15)
    @IBAction func tapEditButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WriteDiaryViewController") as? WriteDiaryViewController else { return }
        guard let indexPaht = self.indexPaht else { return }
        guard let diary = self.diary else { return }
        viewController.diaryDditMode = .edit(indexPaht, diary)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // (14)
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        guard let indexPath = self.indexPaht else { return }
        self.delegate?.didSelectDelete(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
}
