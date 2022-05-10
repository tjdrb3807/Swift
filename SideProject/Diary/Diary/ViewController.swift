//
//  ViewController.swift
//  Diary
//
//  Created by 전성규 on 2022/05/09.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // diaryList 프로퍼티를 프로퍼티 옵저버로 만듬
    // diaryList 배열에 일기가 추가 혹은 변경이 일어날때마다 UserDefaults에 저장된다.
    // 다음 작업: UserDefaults에 저장된 값을 불러오는 기능 구현
    private var diaryList = [Diary]() {
        didSet {
            self.saveDiaryList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuarCollectionView()
        self.loadDiaryList()
        // 다음 작업: 날짜가 최신 순으로 정렬되는 기능 구현 -> ViewController.loadDiaryList method에 기능 추가 구현
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
    
    // UserDefaults를 사용해서 앱을 재실행 했을때 데이터가 유지되는 기능 구현
    private func saveDiaryList() {
        // 일기들을 UserDefaults에 dictionary 형태로 저장
        let date = self.diaryList.map {
            [
                "title": $0.title,
                "contents": $0.contents,
                "data": $0.date,
                "isStar": $0.isStar
            ]
        }
        let userDefaults = UserDefaults.standard  // UserDefaults 에 접근
        userDefaults.set(date, forKey: "diaryList")
        
        // diaryList 프로퍼티를 프로퍼티 옵저버로 만듬. --> 위에서 변경
    }
    
    // UserDefaults에 저장된 값을 가져오는 기능 구현
    private func loadDiaryList() {
        let userDefaults = UserDefaults.standard
        // diaryList Key값을 파라미터롤 넘겨서 일기장 리스트를 가져온다.
        // .object(): Any Type으로 return 되므로 dictionary 배열 형태로 Type Casting한다.
        // Type casting이 실패히면 nil이 반환될 수 있으므로 guard문 으로 Optional Binding 해준다.
        guard let data = userDefaults.object(forKey: "diaryKey") as? [[String: Any]] else {return}
        
        // 불러온 data를 diaryList에 넣어주는 기능 구현
        // diary Type 배열이 되도록 매핑시킨다.
        self.diaryList = data.compactMap {
            // 축약 인자로 dirtionary에 접근
            // title Key로 dictionary value를 가져온다.
            guard let title = $0["title"] as? String else {return nil}
            guard let contents = $0["contents"] as? String else {return nil}
            guard let date = $0["date"] as? Date else {return nil}
            guard let isStar = $0["isStar"] as? Bool else {return nil}
            
            // Diary Type이 되도록 인스턴스화 해서 반환
            return Diary(title: title, contents: contents, date: date, isStar: isStar)
        }
        // 다음 작업: loadDiaryList 메서드를 viewDidLoad에 등록
        
        // 날짜가 최신순으로 정렬되는 기능 구현
        self.diaryList = self.diaryList.sorted(by: {
            // 배열의 왼쪽과 오른쪽의 날짜를 iteration을 돌면서 비교하여 최신순으로 정렬
            $0.date.compare($1.date) == .orderedDescending  // 날짜가 느린 차수능로 정렬
            // 다음 작업: 일기를 등록할때도 최신순으로 정렬되는 기능 구현 -> didSelectRegister 메서드안에 기능 추가
        })
    }
}

extension ViewController: WriteDiaryViewDelegate {
    /* 일기가 작성이 되면 didSelectRegister 메서드 파라미터를 통해 작성된 일기의 내용이 담겨있는 다이어리 객체가 전달이 된다.*/
    func didSelectRegister(diary: Diary) {
        self.diaryList.append(diary)
        self.collectionView.reloadData()
        // 일기를 등록할 때 최신순으로 정렬되는 기능 구현
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        // 다음 작업: Cell의 테두리 설정 -> DiaryCell.swift 에서 설정값 작성
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

// 작업(5): 일기장 리스트 화면에서 일기를 선택하였을 때 일기 상세 화면으로 이동
extension ViewController: UICollectionViewDelegate {
    // didSelectItemAt Method: 특정 Cell이 선택되었음을 알리는 메서드
    // DiaryDetailViewController가 push 되게 구현
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "DiaryDetailViewController") as? DiaryDetailViewController else {return}
        let diary = self.diaryList[indexPath.row]
        viewController.diary = diary
        viewController.indexPath = indexPath
        // 작업(9)
        viewController.delegate = self
        // 다음 작엄(10) -> extention 정의
        self.navigationController?.pushViewController(viewController, animated: true)
        // 다음 작업(6) -> DiaryDetailViewController
    }
}

// 작업(10)
extension ViewController: DiaryDetailViewDelegate {
    func didSelectDelte(indexPath: IndexPath) {
        self.diaryList.remove(at: indexPath.row)
        self.collectionView.deleteItems(at: [indexPath])
        // 다음 작업(11) -> DiaryDetailViewController에서 수정버튼을 누르면 WriteDiaryViewController로 이동
        // WriteDiaryViewController의 storyboard id 값을 WriteDiaryViewController로 설정
        // DiaryDetailViewController.tapEditButton Action함수에 기능 구현
    }
}

