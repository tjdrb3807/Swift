//
//  DiaryDetailViewController.swift
//  Diary01
//
//  Created by 전성규 on 2022/05/12.
//

import UIKit

protocol DiaryDetailViewDelegate: AnyObject {
    func didSelectDelete(indexPath: IndexPath)
    // (21)
    func didSelectStar(indexPath: IndexPath, isStar: Bool)
}

class DiaryDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    weak var delegate: DiaryDetailViewDelegate?
    
    var diary: Diary?
    var indexPaht: IndexPath?
    var starButton: UIBarButtonItem?
    
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
        // (19)
        self.starButton = UIBarButtonItem(image: nil,
                                          style: .plain,
                                          target: self,
                                          action: #selector(tapStarButton))
        self.starButton?.image = diary.isStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        self.starButton?.tintColor = .orange
        self.navigationItem.rightBarButtonItem = self.starButton
    }
    
    @objc func tapStarButton() {
        // (20)
        guard let isStar = self.diary?.isStar else { return }
        if isStar {
            self.starButton?.image = UIImage(systemName: "star")
        } else {
            self.starButton?.image = UIImage(systemName: "star.fill")
        }
        self.diary?.isStar = !isStar
        
        // (21)
        guard let indexPaht = self.indexPaht else { return }
        self.delegate?.didSelectStar(indexPath: indexPaht, isStar: self.diary?.isStar ?? false)
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
        
        // (17): Notification Observing
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(editDiaryNotification(_:)),
                                               name: NSNotification.Name("editDiary"),
                                               object: nil)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        // 수전된 Diary 객체를 받아서 View 에 Update 기능 구현
        guard let diary = notification.object as? Diary else { return }
        guard let row  = notification.userInfo?["indexPath.row"] as? Int else { return }
        self.diary = diary
        self.configuarView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // (14)
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        guard let indexPath = self.indexPaht else { return }
        self.delegate?.didSelectDelete(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
}
