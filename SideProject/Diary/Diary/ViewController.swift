//
//  ViewController.swift
//  Diary
//
//  Created by 전성규 on 2022/05/09.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var diaryList = [Diary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuarCollectionView()
    }
    
    /* Seguway를 통한 화면 전환이므로 prepare 메서드 작성 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let writeDiaryViewController = segue.destination as? WriteDiaryViewController {
            writeDiaryViewController.delegate = self
        }
    }
    
    /* diaryList 에 추가된 일기를 CollectionView에 표시되도록 기능 구현 */
    //CollectionView의 속성을 설정하는 메서드
    private func configuarCollectionView() {
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)  // CollectionView에 표시되는 content에 좌우, 위아래의 간격이 설정갑만큼 생긴다.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter.string(from: date)
    }
}

extension ViewController: WriteDiaryViewDelegate {
    /* 일기가 작성이 되면 didSelectRegister 메서드 파라미터를 통해 작성된 일기의 내용이 담겨있는 다이어리 객체가 전달이 된다.*/
    func didSelectRegister(diary: Diary) {
        self.diaryList.append(diary)
        self.collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    /* CollectionView 에서 DataSource는 CollectionView로 보여지는 콘텐츠를 관리하는 객체 */
    /* 필수 메서드 구현 */
    /* 지정된 섹션에 표시할 셀의 개수를 묻는 메서드 */
    /* diaryList의 개수만큼 Cell이 보이도록 구현 */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }
    
    /* CollectionView의 지정된 위치에 표시할 Cell을 요청하는 메서드 */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else {return UICollectionViewCell()}
        /* dequeueReusableCell(): withReuseIdentifier로 전달받은 재사용 식별자를 통해 재사용 가능한 CollectionVeiw를 찾고 이를 반환한다. */
        /* 재사용할 Cell을 가져오게 되면 이 Cell에 일기의 제목과 날짜를 표시하는 기능 구현 */
        let diary = self.diaryList[indexPath.row]
        cell.titleLable.text = diary.title
        cell.dateLabel.text = self.dateToString(date: diary.date)
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    /* sizeForItemAt: Cell의 Size를 설정하는 메서드 */
    /* 표시할 Cell의 Size를 cgSize로 정의하고 return */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2 - 20), height: 200)
    }
}

