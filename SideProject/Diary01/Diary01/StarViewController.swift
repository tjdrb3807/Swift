//
//  StarViewController.swift
//  Diary01
//
//  Created by 전성규 on 2022/05/12.
//

import UIKit

class StarViewController: UIViewController {

    @IBOutlet weak var collectionVIew: UICollectionView!
    
    private var diaryList =  [Diary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuarCollectionView()
        self.loadStarDiaryList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadStarDiaryList()
    }
    
    // UserDefaults에 저장된 diaryList의 즐겨찾기 된 일기만 가져오도록 기능 구현
    private func loadStarDiaryList() {
        let userDefault = UserDefaults.standard
        guard let data = userDefault.object(forKey: "diaryList") as? [[String: Any]] else { return }
        self.diaryList = data.compactMap {
            guard let title = $0["title"] as? String  else { return nil }
            guard let contents = $0["contents"] as? String else { return nil }
            guard let date = $0["date"] as? Date else { return nil }
            guard let isStar = $0["isStar"] as? Bool else { return nil}
            
            return Diary(title: title, contents: contents, date: date, isStar: isStar)
        }.filter({
            $0.isStar == true
        }).sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionVIew.reloadData()
    }
    
    private func configuarCollectionView() {
        self.collectionVIew.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionVIew.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionVIew.delegate = self
        self.collectionVIew.dataSource = self
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter.string(from: date)
    }
}

extension StarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StarCell", for: indexPath) as? StarCell else { return UICollectionViewCell() }
        
        let diary = self.diaryList[indexPath.row]
        cell.titleLabel.text = diary.title
        cell.dateLabel.text = self.dateToString(date: diary.date)
        
        return cell
    }
}

extension StarViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 10, height: 80)
    }
}
