# CreditCardList App

## Project 진행 순서
1. CardListViewController 생성
   * SubClass of: UITableViewController 
2. Navigation Controller 생성
   * Is Initial View Controller 설정
3. Navigation Root View Controller의 Class: CardListViewController 선언
4. CardListViewController Title: 카드 혜텍 추천
5. JSON Data struct 설정
6. XIB 에서 Cell UI 구성
   * width: 375, height: 80 
   * Horizontal Stack View 추가
     * Alignment: Center, Distributon: Fill
     * Auto Layout
       * Center Vertical in Container
       * Top: 0, Leading: 0, Trailing: 10, bottom: 0
     * Image View 추가
       * Image: creditcard.fill
       * WidthL: 80, Height: 40
     * Vertical Stack View 추가
       * Alignment: Leading
       * Distribution: Fill Equally
       * Lable 추가
         * title: 신용카드
         * Font Style: bold, Size: 19
       * Horizontal Stack View 추가
         * Alignment: Center
         * Distribution: Fill Proportionally
         * Label 2개 추가
           * 첫 번째 Label
             * Title: 0위
             * Color: Dark Gray
           * 두 번째 Label
             * Title: 0만원 증정
             * Color: White
             * Background Color: Ligth Gray
             * Alignmnet: Center
             * Font Style: Bold, Size: 12
             * Width: 80, Height: 20
     * Image View 추가
       * Image: chevron.right
       * Width: 20, Heigth: 20
7. UITableViewDelegate를 통해서 데이터를 전달받을 수 있도록 Cell에다 어떠한 데이터를 표현하기 위해서 UI 객체를 IBOutlet 변수 선언
8. Storyboard의 Cell 영역에서 Custom으로 만든 Cell 객체를 지정
   * CardListViewController.Table View Cell.Identifier: CardListCell 설정
   * CardListViewController.Table View Cell.Class: CardListCell 설정
9. CardListViewController.viewDidLoad()에 Cell Register
10. UITableViewController의 필수 메서드 numberOfSections, cellForRowAt 작성
11. Cocoapods을 통해 Kingfisher 라이브러리 설치 
    * 일반적으로 Image URL만 전달받은 상태에서 ImageView에 표현한다.  
12. Cell의 높이 지정
    * heightRowAt
13. CardDetailViewController 설정
    * SubCalss of: UIViewController
14. Storyboard View Controller 생성
    * CardListCell 의 Accessory Action: Show 설정  
    * Class: CardDetailViewController, Identifier: CardDetailViewController    
    * Title: 카드 혜택 상세
    * Vertical Stack View 생성
      * Alignment: Fill
      * Distribution: Fill
      * Spacing: 20
      * Center Horizontally In Safe Area
      * Center Vertically In Safe Area
      * Leading: 20, Trailing: 20
    * Label 추가
      * Title: 신용카드 쓰면\n0만원드려요.
      * Font Color: Dark Gray
      * Font Style: Heavy
      * Font Size: 28
      * Lines: 0
      * Alignment: Leading
    * View 추가 
      * Height: 200
      * 움직이는 이미지(움짤)을 넣기위해 외부 라이브러리 `lottie-ios` 설치
      * Class: AnimationView 설정
        * Module이 Lottie로 변경된 것을 확인할 수 있다.
        * CardDetailViewController 에 Image View 의 IBOutlet 변수 선언
15. money.json 을 XCode Project에 추가
16. money lottie animation 구현
17. CardDetailView 의 Image View 아래에 상세내용 표시
    * Horizontal Stack View 생성      
      * Alignment: Center
      * Distribution: Fill
      * Spacing: 30
      * Label 2개 추가
        * 첫 번째 라벨의 Content Hugging Priority.Horizontal: 1000
    * Horizontal Stack View 4개 복사
      * 각각의 Label IBOutlet 변수 선언
18. 데이터를 받았을 때 어느 Label에 어떻게 표현할지 구현
    * CardListViewController 에서 Detail한 내용을 받기 위한 변수 선언
      * 만약을 위한 Optional 처리
    * promotionDetail 안에 포함된 각각의 내용을 각 Label에 적적하게 표현하는 기능 구현
      * viewWillAppear에 선언
19. CardDetailViewController가 Cell을 Tap할 때 표현 되도록 구현
    * CardListViewController에서 구현
    * 어떠한 Cell을 Tap했을 때를 기준으로 제어하고 싶을 때는 Deleaget중에 didSelectedRowAt 을 사용    
20. Firebase Project 생성 
21. Realtime Databese 생성
22. Cocoapods `Firebase/Database` install  
23. AppDeleaget에서 Firebase 초기화 
24. CardListViewController에서 Database의 Data를 가져오므로 `import FirebaseDatabase`
25. `DatabaseReference` Optional 선언
    * FribaseDatabase 콘손에서 만들 레퍼런스를 의미한다.
    * viewDidLoad에 선언
      * Firebase가 내가 생성한 Database를 잡아내고 추후에 Database에서 만들 Data 흐름을 주고 받는다.
26. FirebaseDatabase에 넣어둔 creditCard List 를 가져와 읽는 기능 구현
    * 실시간 Database는 snapshot을 이용해서 Data를 불러온다. 
    * Reference에서 값을 지켜보고 있다가 값을 snapshot이라는 객체로 전달한다. 
    * 개발자는 snapshot 객체를 클로저 내에서 가공해서 사용한다.
    * 전달되는 snapshot에서 value는 개발자가 이해하고 있는 Database의 자료구조 형태를 지정해주는 것이다.
    * 다움캐스팅으로 정확한 타입을 지정해주지 않으면, Database는 snapshot에서 전달받은 값을 이해하지 못해서 항상 nil을 방출하게 된다.
    * 정확한 타입으로 전달 받았다면 Codable의 Decodable을 통해서 기존에 만들어 두었언 CreditCard 객체의 배열로 만들어 줄 수 있다.
    * 이 후 전달을 잘 받았다면, Tabable Reload를 해주어야 가져온 데이터가 화면에 표현된다. 
      * reloadData()는  UI를 표현하는 것으로 메인 스레드 에서 작동히야 하기에 DispatchQueue.main.async를 설정한다. 

