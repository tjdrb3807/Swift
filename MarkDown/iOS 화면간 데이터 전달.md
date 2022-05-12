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
      
      overried func viewDidLoad() {

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