# iOS 화면 전환 방법
참고 Project: https://github.com/tjdrb3807/Swift/tree/main/SideProject/ScreenTransactionExample02/ScreenTransactionExample02

## 화면 전환 방법
1. 소스코드를 통해 전환하는 방식
2. Storyboard를 통해 전환하는 방식
3. ViewController에서 다음 ViewController를 호출하여 전환하는 방식(Presentation 방식)
4. ViewController의 View 위에 다른 View를 가져와서 바꿔치우는 방식
   > 메모리 누수 위헙이 있으므로 사용하지 않는것을 권장.   
5. Navigation Controller를 사용하여 전환하는 방식

## 소스코드를 통해 전환하는 방식
* `self.storyboard?.instantiateViewConroller`: Storyboard에 존재하는 ViewController를 인스턴스화
 
   ```Swift
   @IBAction func tapCodePuchButton(_ sender: UIButton) {
       guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePushViewController") else { return }
   } 
   ```
   > Storyboard에서 ViewController의 Identity Storyboard Id를 지정하고 해당 식별자를 identifier Parameter에 넘겨준다.   
   반환 타입이 Optional 이므로 guard문으로 Optional binding   

## Storboard를 통해 전환하는 방식
* 화면 전환용 객체 Segueway를 사용하여 화면 전환
* `Segueway`: 두 개의 View Controller 사이에 연결된 화면 전환 객체
  > Segueway를 이용하면 별도의 코드 없이 Storyboard에서 화면 전환이 가능하다. 
* `Action Segueway`: 출발점이 Button 등인 경우
  * Storyboard에서 Drag And Drop 을 통해 Action Segue 선택
 
    ![](img/img12.png)
    ![](img/img13.png)
* `Manual Segueway`: 출발점이 View Controller 자체인 경우

## Presentation 방식
* `present`: 기존 ViewController위에 새로운 ViewController의 화면을 덮는 방식  
  ```Swift
  func present(_ viewControllerToPresent: UIViewController,
               animated: Bool,
               complition: (() -> Void? = nil))
  ``` 
  * 첫 번째 Parameter에 Presentation 방식으로 이동할 화면의 ViewController를 넘겨준다.
  * animated: 화면 전환시 애니메이션 표화 추가 여부를 Bool 값으로 넘겨준다.
  * compliation: 화면 전환은 비동기 방식으로 처리되므로 화전 전환 이후에 처리히야할 코드가 있다면 compliation 클로저 안에 작성한다.

* `dismiss`: present된 화면에서 이전 화면으로 돌아가기 위한 메서드
  ```Swift
  func dissmiss(animated: Bool,
       complition: (() -> Void? = nil))
  ``` 

## Navigation Controller를 통해 전환하는 방식
* View Controller의 화면 전환을 직접 컨트롤 하며, App에 Navigation 정보를 표시하는 역할과 Navigation Stack(LIFO으로 Child View Controller를 관리한다.
* `pushViewController`: 새로운 화면을 표시
 
  ``` Swift
  func pushViewController(_ viewController: UIViewController, animated: Bool)
  ```
* `popViewController`: 이전 화면으로 전환

  ```Swift
  func popViewController(animated: Bool) -> UIViewController?
  ``` 