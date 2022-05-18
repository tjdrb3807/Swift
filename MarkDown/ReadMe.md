# UITabBarController, UICollectionView


## UITabBar
* 앱에서 서로 다른 하위작업, 뷰, 모드 사이의 선택을 할 수 있도록, 탭바에 하나 혹은 하나 이상의 버튼을 보여주는 컨트롤러
 
    ![](img/img02.png)
    > 일반적으로 TabBar는 UITabBarController와 함께 사용하지만 App에서 독립적인 컨트롤로 사용할 수 있다.

<br>

## UITabBarController
* 다중 선택 인터페이스를 관리하는 Container View Controller로, 선택에 따라 어떤 Child View Controller를 보여줄 것인지가 결정
 
    ![](img/img03.png) 

  * TabBarController 인터페이스에 있는 각 Tab은 CustomViewController에 연관되어 있으며, 사용자가 특정 Tab을 선택하면 TabBarController는 그에 상응하는 ViewController의 Root View를 표시한다. 
  * TabBarController는 UIViewController를 상속받는 Class 이므로, View 속성을 갖는다.
  * 해당 View는 TabBarView와 Custom Content를 포함한 View이다.
  * TabBarView는 사용자를위해 선택 컨트롤러를 제공하며, 하나 혹은 하나 이상의 Tab Bar Item으로 구성된다.

<br>

## UICollectionView
* 데이터 항목의 정렬된 컨렉션을 관리하고 커스텀한 레이아웃을 사용해 표시하는 객체
* TableView 처럼 CrollView를 상속받고 있으며, 다양한 Layout을 보여줄 떄 주로 사용한다.
 
    ![](img/img05.png)
    > TableView는 List 형태로만 표현이 가능하지만, CollectionView는 List 형태로도 표현이 가능하고 위의 이미지처럼 다양한 형태로 표현이 가능하다.

* CollectionView의 구성
  
    ![](img/img06.png) 
    * `Supplementary View`: 세션에 대한 정보를 표시
      * Header, Footer
      * 필수로 구현할 필요는 없다.
    * `Cell`: CollectionView의 주요 콘텐츠를 표시
      * CollectionView는 CollectionView Data Source 객체에서 표시할 Cell의 정보를 가져온다.
    * `Decoration View`: CollectionView에 대한 배경을 꾸밀 때 사용
      * Layout객체는 Decoration View를 사용하여 Custom한 배경을 구현할 수 있다.

<br>

## CollectionView Layouts
* CollectionView는 Layout 객체를 통해 CollectionView 내에 Item 배치 및 시각적 스타일을 결정한다.
* Layout객체가 하는 일은 Cell, Supplementary View, CollectionView의 bound, 내부에 있는 Decoration View의 위치를 결정하고 시각자 상태의 정보를 CollectionView에 제공한다. 
* UICollectionView에서는 `UICollectionViewFlowLayout`을 사용해서 항목들을 정렬할 수 있으며, 해당 클래스를 사용하게 되면 Cell을 원하는 형태로 정렬할 수 있다.
* FlowLayout은 Cell의 선형 경로를 배치하며, 최대한 Row를 따라 많은 Cell을 채우다가 현재의 Row에 더이상의 Cell이 들어갈 수 없게 된다면 새로울 Row를 만들어 계속해서 배치해나간다.
  
    ![](img/img07.png)
* UICollectionViewLayout
* UICollectionViewFlowLayout

<br>

## UICollectionViewFlowLayout
* 구성 단계
  1. Flow Layout 객체를 작성하고 컬렉션 뷰에 이를 할당한다.
  2. Cell의 width, heigth를 정한다.(반드시 지정! 만약 지정하지 않을 경우 값이 0이 되어 표시되지 않느다.)
  3. 필요한 경우 Cell들 간의 좌우 최소 간격, 위아래 최소 간격을 설정한다.
  4. 섹션에 header와 footer 가 있으면 이것들의 크기를 지정한다.
  5. layout의 스크롤 방향을 설정한다. 
* FlowLayout은 Cell과 Row사이에 간격을 설정할 수 있다.
  * 여기서 설정하는 간격을 최소 간격으로 배치하는 방법에 따라 지정한 값보다 큰 값으로 설정될 수 있다.
  * Cell들의 크기가 같으면 최소로 설정한 간격을 지킬 수 있지만, Cell들의 크기가 다르면 실제 간격이 다를 수 있다.

    ![](img/img08.png)

    ![](img/img09.png)

<br>

## UICollectionViewDataSource
* 컬렉션 뷰로 보여지는 콘텐츠들을 관리하는 객체
* DataSource를 정의하기 위해서는 UICeollvetionViewDataSource protocol을 준수해야 한다.
* DataSource의 역학은 CollectionView에 몇개의 섹션이 있는지 특정 섹션에 몇개의 Cell이 존재하는지 특정 섹션이나 셀의 컨텐츠를 보여주기 위해 어떤 View를 사용할 것인가에 대한 정보를 CollectionView에 제공하는것이다.
* UICollectionViewDataSource protocol의 주요 Method

    ![](img/img10.png)
    > optional 키워드가 없는 메서드들은 필수 메서드

<br>

## UICollectionViewDelegate
* 콘텐츠의 표현, 사용자와의 상효작용과 관련된 것들을 관리하는 객체

<br>

## CollectionView 와 관련된 핵심 객체들의 관계
* CollectionView는 DataSource에서 보여줄 Cell에 대한 정보를 가져온다.
* Layout 객체에서 해당 Cell에 속하는 위치를 결정한다.
* 하나 이상의 Layout 속성 객체로 CollectionView에 전송한다.
* CollectionView는 Layout의 정보를 실제 Cell이나 다른 View들과 결합하여 최종적으로 사용자에게 보여준다.
![](img/img11.png)


## numberOfSection
* 지정된 Section에 표시할 Cell의 개수

  ```Swift
  extension ViewController: UICollectionViewDataSouce {
    func collectionView(_ collectionView: UICollectionView, numberOfItemInSection section: Int) -> Int {
      return self.dirayList.count
    }
  }
  ```

## cellForItemAt  ->> ToDoList 앱 다시 듣기
* CollectionView의 지정된 위치에 표시할 Cell을 요청
  ```Swift
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPaht) -> UIControllerViewCell {
    guard let cell = collectionView.dequeueReuseableCell(withResueIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else { return UICollectionViewCell() }
  }
  ``` 
    * dequeueReuseableCell 메서드를 사용해서 Storyboard에서 구성한 CustomCell을 가져온다.
      * withReuseIdentifier로 전달받은 재사용 식별자를 통해 재상요 가능한 CollectionView는 찾고 이를 반환해준다.
    * Down Casting 실패시 빈 UICollectionViewCell 반환

## didSelectItemAt
* 특정 Cell이 선택됐음을 알리는 메서드