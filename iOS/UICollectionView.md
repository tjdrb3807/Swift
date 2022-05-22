# UICollectionView

## 정의   
`유연하게 변경 가능한 Layout을 사용하여 특정 타입 형태로 정렬된 데이터 집합을 표시하는 방법`   
> UICollectionView의 가장 일반적은 용도는 항목을 격자와 같은 배열로 표시하는 것이지만,   
> iOS의 UICollectionView는 행과 열의 나열 뿐만 아니라 다양한 배열 구현을 가능하게 한다.   


UICollectionView는 Data와 해당 Data 를 표시하는 시각적 요소를 엄격하게 구분하고 있다.   
즉, 데이터를 어떻게 관리할지 또 그러한 데이터를 어떻게 나타낼지 모두 별도로 고려해서 개발해야 한다.   
동시에 사용자에게 어떠한 화면을 보여줄지에 대한 View를 가져와서 화면에 배치하는 모든 작업 또한 개발되어야 한다.   
Viwe를 어떻게 배치할지 각각의 View는 어떤 속성을 갖는지 지정할 수 있는 Layout객체와 함께 View작업을 수행한다.   
따라서 Data 영역 Layout영역은 각각 분리가 되어서 각자의 역할에 맞는 정보를 제공하고 UICollectionView는 이러한 두 구분을 종합해서 최종 형태를 구축하게 된다.    


UICollectionView는 Data가 화면에 배열되고 표시되는 방식과 표시되는 Data를 분리하도록 디자인 되어있다.   
표시할 Data를 엄격하게 관리하는 동시에 시각적인 표현은 다양한 객체에 의해서 관리된다.   
(pdf에서 이미지 첨부)
UIKit에서 제공하는 UICollectionView 관련 Class 와 Protocol 을 각각의 역할에 따라 정리한 표   
대부분의 클래스는 하위 클래스화할 필요 없이 있는 그대로 사용하도록 설계되었기 때문에 상대적으로 아주 적은 코드로도 복작한 UI를 구현할 수 있게 되어있다.   

* Top-level Containmnet ans Management   
최상위 레벨에서 관리 역할을 하는 UICollectionView와 CollectionViewController가 존재한다.   
UICollectionView 객체는 CollectionView가 갖는 Contents가 보여지는 영역을  어떻게 할지 정의한다.   
이 클래스는 UIScrollView를 상속하기 때문에 이후에 다룰 Layout객체에서 수신하는 Layout정보를 기반으로 데이터를 쉽에 표시할 수 있도록 도와준다.    
UICollectionViewController는 이러한 CollectionView를 ViewController 수준에서 관리할 수 있게 해준다.
UITableView와 UITableViewController와 같은 관계라 생각하면 된다. 

* Content Management   
DataSource는 UICollectionView와 연결된 가장 중요한 객체로서 반드시 제공해야 하는 객체이다.   
DataSource는 ContnetView의 Content를 관리하고 해당 Content를 표시하는데 필요한 View를 만든다.    
이러한 DataSource를 구현하려면 CollectionView DataSource Protocol 을 준수하는 객체를 만들어야 한다. 

UICollectionViewDelegate를 사용하면 ColletionView에서 발생하는 특정 Action이나 상황을 캐치해서 View의 동작을 사용자 지정화 할 수 있다.   
Delegate는 DataSource와 달리 선택사항이다. 

* Presentation   
UICollectionView에 표시되는 모든 View는 UICollectionReuseableView의 인스턴스 이어야 한다.    
이 클래스는 CollectionView에서 사용중인 재활용, 재사용 매커니즘을 지원한다.   
매번 새 View를 계속해서 만드는 대신에 이 View를 재사용해서 일반적으로 성능이 향상되고 특히 스크롤하는 동안에 사용자가 느껴지는 성능적인 요소들이 향상이 된다.   

UICollectionViewCell 객체는 주 Data항목에 사용하는 재사용 가능한 View로 특정 유형의 배열을 갖게된다.   

* Layout   
Layout을 UICollectionView만 갖고있는 속성으로서    
UICollectionView Layout과 그 하위 Class들을 Layout 객체라 묶어서 말하며, UICollectionView 내에서 Cell과 ReuseableView의 위치, 크기 시각적 속성 등을 정의하는 역할을 한다.   
이러한 책임 분리를 통해서 App에서 관리하는 Data 객체를 변경하지 않고도 Layout을 동적으로 변경할 수 있다.   
Layout이라는 말을 보고 부모 View가 자식 View를 재배치하는데 사용하는 LayoutSubView 메서드를 떠올리 수 있지만, UICollectionView 에서 말하는 Layout은 layout 메서드에서 구현하는 상황과는 전혀 다르다.   
UICollectionView Layout 객체는 Layout대상이 되는 View를 실재로 소유하지는 않기 때문이다.   
따라서 Layout 프로세스 동안 UICollectionView layout 객체는 UICollectionView Cell과 ReuseableView 등의 위치, 크기 시각적 모양 이러한 것들을 설명하는 속성을 알려주는 layout 속성 객체를 만든다.   
그런 다음에 UICollectionView가 이러한 속성을 실제 View 객체에 적용하게 된다.   
layout객체는 UICollectionView 내에서 Data 항목이 삽입, 삭제, 이동 할때 마다 UICollectionViewUpdateItem 클래스의 인스턴스를 받는다 (이 클래스의 인스턴스는 개발자가 직접 만들 필요는 없다.)   

* Flow Layout   
IUCollectionViewFlowLayout 클래스는 Grid(그리드)나 기타 선 기반 레이아웃 을 구현하는데 사용하는 구체적인 레이아웃 객체이다.  
클래스를 있는 그대로 또는 Delegate와 함께 사요하기 때문에 레이아웃 정보를 동적으로 사용자화 할 수 있다. 

* Layout metric을 나타내는 layout 객체   
(pdf 이미지 첨부)   
세로 스크롤의 FlowLayout이 Cell, Header, Footer 이런 서플리먼트리 viwe를 정렬하는 방법을 설명하고 있다.   
세로 스크롤 flow 레이아웃 에서는 컨텐츠 영역의 넓이가 고정 상태로 유지되고 높이가 컨텐츠를 수용할 수 있도록 유동적으로 커진다   
이러한 면적을 계산하기 위해서 레이아웃 객체는 View와 Cell을 한번에 하나씩 배치하고 각각의 가장 적합한 위치를 선택한다.   
flow 레이아웃의 경우에 레이아웃 객체 또는 delegate를 사용해서 cell과 서플리멘터르 뷰의 크기가 attribute(속성)으로 지정되게 된다.   
레이아웃을 이런 속성을 사용해서 각 view를 배치할 수 있게 계산한다.   


* 5가지 요소를 합쳐서 ColletionView가 표시된 모습   
(pdf 이미지 첨부)   
UICollectionView는 우측의 DataSource에서 표시할 Cell에 대한 정보를 가져온다. 
그리고 DataSource와 Delegate 객체는 사용자 지정 객체 Cell 선택, 강조 이러한 표시를 포함해서 컨텐츠를 관리하는데 사용된다.    
좌측에 있는 layout객체들을 해당 Cell의 속하는 위치를 결정하고 해당 정보를 하나 이상의 layout 속성 객체 형태로 CollectionView에 보내는 역할을 한다.   
그런다음 CollectionView는 이 layout정보를 실제 Cell에 포함한 다른 ReuseableView들과 병합하여 최종적으로 보여지는 프레임을 만들게 된다. 

---

* 다양한 layout이 중첩된 형태로 나타날 경우 
애플에서도 UICollectionView는 FlowLayout만 이용해서 Layout을 설정하도록 권장하고 있다.   
Layout을 커스텀하면 다이나믹하고 다양한 Layout을 만들 수는 있지만, 코드가 아주 길어질 수 밖에 없으며, 코드가 길어진다는 것은 버그 발생률이 높아지고 가독성이 떨어지며 유지보수도 힘들어 진다.    

이러한 어려움을 개선하고 좀더 직관적이고 간편한 레이아웃 구현을 위해서 iOS13+ 부터 `UICollectionViewCompositionalLayout`을 제공한다.   
직역하면 구성 가능한 레이아웃으로서 복잡한 UI를 그리는 것이 목표더라도 각각의 구성요소 자체는 단순해서 이런 단수한 구성요소를 각각으로 여러가지 방식으로 구성해서 복작한 UI를 구현한다.    
유연하게 변경 가능하고 응용가능해서 기존의 FlowLayout 이용한 Layout은 물론 Custom으로 가능했던 더 복작한 Layout도 작성 할 수 있다,   
마지막으로 퍼포먼스를 프레임워크 단위에서 알아서 수행하여 개발자는 성능에 대한 고민을 덜 하고도 레이아웃 목적에만 집중 할 수 있다. 


* CompotionalLayout을 구현하려면 세가지의 main 구성요소가 필요하다.   
(pdf 소스 이미지 첨부)   
item, group, section      
이 세가지 구성요소는 사다리 처럼 레이아웃 size를 통해서 커스텀 하게 사이즈를 지정하고, 이렇게 만들어진 size객체는 item, group의 initialization(초기화)객체로 들어가게 된다.  
마지막으로 layout section을 컴포지셔널 레이아웃 생성에 들어간다.  

* Code가 UI내에서 어덯게 작동하는가?   
(pdf 이미지 첨부)   
Item: ColletionView에서 개별 컨텐츠의 크기, 공간, 정렬 방법에 대한 청사진 역할   
화면에 랜더링 되는 단일 뷰를 나타낸다.   
일반적으로 Item 은 Cell이지만 항목은 Header나 footer, 데코레이션 뷰와 같은 서브멘터리 뷰를 포함해서 말한다.   
각 Item은 너비와 높이 디멘션을 갖는 고유한 사이즈를 지정한다.   
아이템은 상대적인 치수를 절대값으로 표현하거나 시스템 글꼴 크기 변경에 대한 응답으로 런타임시에 변경될 수 있는 추정값(수정값?) 같은 여러가지 방식으로 값을 표현할 수 있디.   

Size: item을 초기화할떄 Size를 넣어준다.   
사이즈는 넓이와 높이 값을 갖게 되며 이러한 넓이와 높이값을 치수(디멘션)이라 말한다.   
디멘션을 세가지 타입으로 설정할 수 있다.   
Absolute: 절대적인 값으로 point값을 넣어서 정확한 치수를 지정할 수 있다.
(img 첨부)
Estimate: 추정값(예상값)을 의미하며, 데이터가 로드되거나 시스템 글꼴 크기가 변경되는 것과 같이 런타임에 컨텐츠 크기가 변경될 수 있는 경우에는 Estimate를 사용한다.   
초기 추정 크기를 제공하면 시스템이 나중에 실제 값을 계산해서 반영한다.   
Absolute와 같이 예상되는 포인트 값을 넣어주면 된다.   
Fractional: 분수, 비율이라는 의미로 분수값을 사용해서 아이템 컨테이너를 기준으로 값을 정의한다.   
이미지 코드의 의미는 컨테이너 넓이의 20%와 동일한 넓이와 높이 를 갖는 정사각형 Item   
만약에 컨테이너의 크기가 변경되면 절대값을 그에 따라서 커지고 축소된다.   

Group: Item들이 서로 관련하여 배치되는 방식을 결정해서 결합하는 역할을 한다.   
Group는 항목을 가로행, 세로열 또는 사용자 지정 배열로 배치할 수 있다.   
각 Group는 자신의 사이즈를 지정할 때 절대값으로 또는 시스템 글꼴 크기의 변경에 따라 변경될 수 있는 추정 값으로 또는 컨테이너의 상대적인 치수를 대비하는 플렉셔녈(유연)한 방식으로 표현할 수 있다.   
왜냐하면 Group는 CollecitonLayoutItem의 하위 클래스 이기 떄문이다.    
따라서 Itme처럼 작동할 수 있다.   
즉 Group는 Item만 포함하는 것이 아니라 다른 Group를 포함할 수 있다.(Nested Group), Stack View와 유사   
결국 다른 항목 및 Group와 결합하여 좀더 복잡한 Layout으로 만들 수 있따.   
이렇게 만든 Group를 통해 Section을 initialization(초기화)할 수 있다.   

Section: Group으로 이루어져 있다.  
CollectionView Layout에는 하나 이상의 Section이 존재한다.   
Section은 각각의 Layout을 각각의 영역으로 분리하는 방법을 제공한다.   
각 Section은 CollectionView의 다른 Section과 레이아웃이 같거다 다를 수 있다.   
이러한 Section의 Layout은 Section을 만드는데 사용되는 Group의 속성에 의해서 결정된다.   
각 Section은 다른 Section과 구분하기 위해 고유한 Background나 Header, Footer들을 넣을 수 있다.   

Layout: 위에서 언급한 모든 구성요소들을 반연   
Layout은 Section이 있어야 하고 Section은 Group이 있어야 하고 Group은 Item이 필요하다.   
Item과 Group은 넓이와 높이 디멘션을 갖는 Size를 가질 수 있다.   


---
* SnapKit 알아보기   
Auto Layout을 코드로?   
Auto Layout에는 고려해야할 다양한 Constrate가 존재한다.   
SnapKit은 Code 베이스로 UI를 구현하고 Auto Layout을 고려해야 할 때 아주 직관적이고 간편하게 작성할 수 있도록 도와주는 Open Source Framworke 

SnapKit과 같으 외부 라이브러리를 활용하기 위해서 기존에는 Cocoapods를 사용했지만, Swift Package Manager를 사용한다.    
Package를 사용하고자하는 프로젝트에 SnapKit에 대한 dependency 주소를 넣어주면된다.   



