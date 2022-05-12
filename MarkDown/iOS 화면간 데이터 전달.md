# iOS 화면간 데이터 전달
## Code를 통한 데이터 전달
* `instantiateViewController Method에 전환되는 View의 View Controller Class Type으로 Down Casting`
 
  ```Swift
  class ViewController: UIViewController {
      
      @IBAction func tapCodePushButton(_ sender: UIButton) {
          guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePushViewController") as? CodePushViewController else { return }
      }
  }
  ```
* 각 Type에 맞는 View Controller Class로 Down Casting 하게되면 `Down Casting 한 View Controller의 메인 Property에 접근`할 수 있다.

  ```Swift
  class CodePushViewController: UIViewController {

      var name: String?

      ...
  }

  class ViewController: UIViewController {
      
      @IBAction func tapCodePushButton(_ sender: UIButton) {

          ...

          viewController.name = "Jeon Seong Gyu"
      }
  }
  ```
  > 다른 화면으로 Push or Present 되기 전에 메인 Property에 값을 넘겨주게되며, 전환된 화면으로 데이터를 넘겨준다.
* viewDidLoad Method에 넘겨받은 데이터를 작성
  ```Swift
  class CodePuchViewController: UIViewController {
      
      override func viewDidLoad() {

          @IBOutlet weak var nameLabel: UILable

          super.viewDidLoad()
          if let name = name {
              self.nameLabel.text = name
          }
      }
  }
  ``` 
  > if let 으로 name 변수를 Optional Binding
  
## Segueway를 통한 데이터 전달
* `prepare`: 전처리 Method prepare를 Override 하게되면 Segueway를 실행하기 직전에 시스템에 의해서 자동으로 prepare Method가 호출된다.
 
  ```Swift
  class ViewController: UIViewController {
      
      ...

      override func prepare(for segue: UIStoryboardSegue, sender: Ang?) {
          if let viewController = segue.destination as? SeguePushViewContoller {
              viewController.name = "Jeon Seong Gyu"
          }
      }
  }
  ``` 
  > destination: 전환하려는 ViewController의 인스턴스를 가져올 수 있다.

## 전환된 화면에서 이전 화면으로 데이터 전달
* `Delegate Pattern`: 위임자를 갖고있는 객첵가 다른 객체에게 자신의 일을 위임하는 형태의 디자인 패턴
* 프로토콜 정의 및 Delegate 변수 설정
  ```Swift
  protocol SendDataDelegate: AnyObjec {
      func sendDate(name: String)
  }

  class CodePresentViewController: UIViewController {

      weak var delegate: SendDataDelegate?
  }
  ``` 
  > Delegate Pattern을 사용할 때 Delegate 변수 앞에는 `weak` 키워드를 붙여야 한다.   
  weak 키워드가 누락되면 강한 순환참조가 걸려서 메모리 누구사 발생할 수 있다.

* 이전 화면에서 Delegate 위임 받기
 
  ```Swift     
  class ViewController: UIViewController {

      @IBAction func tapCodePresentButton(_ sender: UIButton) {

          ...

          viewController.delegate = self
      }
  }
  ```
  > ViewController에서 SendDataDelegate Protocol을 채택하라는 Error Message 발생

  ```Swift
  class ViewController: UIViewController, SendDataDelegate {
      ...
  }
  ```
  > SendDateDelegate를 채택하기 위해 모든 메서드를 구현하라는 Error Message 발생

  ```Swift
  class ViewController: UIViewController, SendDataDelegate {

      @IbOutlet weak var nameLabel: IULabel

      ...

      func sendDateDelegate(name: String) {
          self.nameLabel.text = name
          self.nameLable.sizeToFit()
      }
  }
  ```

  ```Swift
  class CodePresentViewController: UIViewController {

      ...

      @IBAction func tapBackButton(_ sender: UIButton) {
          self.delegate?.sendData(name: "Jeon Seong Gue")
      }
  }
  ```
  > 데이터를 전달받은 ViewController에서 Protocol을 채택하고 delegate를 위임받게 되면 sendData 호출