## assert
* 특정 조건을 체크하고, 조건이 성립되지 않으면 메세지를 출력하게 할 수 있는 함수
* assert 함수는 디버깅 모드에서만 동작하고 주로 디버깅 중 조건의 검증을 위하여 사용한다.
 
  ```Swift
  var value = 0
  assert(value == 0)  // 조건 성립으로 통과

  value = 2
  assert(value == 0, "값이 0이 아닙니다.")  // 조건이 성립되지 않아 Error 발생      
  ``` 
  > RuntimeError가 발생   
  실행 화면에 Assertion failed: 값이 0이 아닙니다 출력

<br>

## guard
* 뭔가를 검색하여 그 다음에 오는 코드를 실행할지 말지 결정 하는 것
* guard 문에 주어진 조건문이 거짓일 떄 구문이 실행된다.
* guard 문은 주로 잘못된 값이 함수에 들어오는것을 방어하기 위해서 사용된다.   
 
  ```Swift
  /*
    guard 조건 else {
        // 조건이 false 이면 else 구문이 실행되고
        return or throw or break 를 통해 이 수 코드를 실행하지 않도록 한다.
    }
  */
  func guardText(value: Int) {
      guard value == 0 else {return}
      print("안녕하세요.")
  } 

  guardText(valud: 2)
  ``` 
  > value 값이 0이 아니므로 guard문에 막혀 guard문 이후의 print 함수가 출력되지 않는다.   
  value 값이 0일때만 "안녕하세요"가 출력된다.  

## Optional Binding
* guard 문 으로 Optional 표장지를 제거하는 Optional Binding도 가능하다.

  ```Swift
  func guardText(value: Int?) {
      guard let value = value else {return} 
      print(value)
  }

  guardTest(value: 2)
  guardTest(value: nil)
  ```
  > value에 값이 들어가있으면 Optional 포장지를 벗겨서 value 라는 상수에 대입시킨다   
  value의 값이 nil이라면 else 구문을 실행하여 함수가 return 된다.
* if let 문법을 사용한 Optional Binding과는 다르게 `guard let 을 사용하면 Optional Binding된 상수를 조건문 범위 밖에서도 사용할 수 있다.`

## Protocol
* 특정 역할을 하기 위한 메서드, 프로퍼티, 기타 요구사항 등의 청사진을 정의한다
* `구조체, 클레스, 열거형은 프로토콜을 채택`해서 특정 기능을 실행하기 위한 `프로토콜의 요구사항을 실제제로 구현`할 수 있다.
* 프로토콜을 채택한 구조체, 클래스, 열거형에게 프로토콜에 정의한 요구사항을 준수하라고 요청한다.
* 이때 `프로토콜이 요구하는 사항을 모두 충족하면 해당 타입이 채택한 프로토콜을 준수한다`고 말할 수 있다.

   ```Swift
   /*
   protocol 이름 {
       // 프로토콜 요구사항 정의
   } 
   */
   protocol SomeProtocol01 {

   }

   protocol SomeProtocol02 {

   }

   struct SomeStruct: SomeProtocol01, SomeProtocol02 {  // 구조체에 프로토콜이 채택

   }

   /*
   calss SomeClass: SuperClass, FirstProtocol, AnotherProtocol {

   }
   *
   ```
   > 상속받은 클래스가 프로토콜을 채택시 SuperClass를 제일 앞에 두고 그 뒤로 프로토콜을 나열한다.   

* ### Protocol Property 요구사항
  ```Swift
  protocol FirstProtocol {
      var name: Int { get set }   // 읽기, 쓰기 전용 Property
      var age: Int { get }        // 읽기 전용 Property
  } 

  protocol AnotherProtocol {
      static var someTypeProperty: Int {get set}
  }
  ``` 

  * Protocol이 property를 요구할때는 `변수(var)로 요구`해야한다.
  * `프로퍼티 이름과 타입만 지정`하면 된다. 
  * Protocol에서 읽기만 가능한 프로퍼티를 요구하는 경우에는 모든 종류의 프로퍼티를 설정할 수 있다.
  * Protocol에서 `TypeProperty를 요구하려면 static 키워드를 사용`해야 한다.
   
* Protocol에서 Property요구사항을 정의하고 Struct에서 정의한 Protocol 채택
 
  ```Swift
  protocol FullyNames {
      var fullName: String { get set }
  }

  struct Person: FullyNames {
      /* 채택한 Protocol의 요구사할을 구현하지 않으면 채택한 Protocol을 준수하지 않으므로 Error 발생 */
      var fullName: String
  }
  ``` 
  > Protocol은 자신을 채택한 Type의 Method를 요구할 수 있다.    
  이때 요구하는 Method는 Instnace Method, Type Method 모두 가능하다.
* ### Protocol Method 요구사항 
  ```Swift
  protocol SomeProtocol {
      func someTypeMethod()
  }

  struct SomeStruct: SomeProtocol {
      func someTypeMethod() {
          /* 구현하고 싶은 기능 작성 */
      }
  }
  ``` 
  > Protocol에서 Method를 정의할 떄 중괄호({ })나 Method Body는 필요 없지만, Method에 필요만 Parameter는 정의해야한다.   
  이떄 Parameter의 Default Value는 지정할 수 없다.

### Protocol Initializer 요구사항
* Protocol은 자신을 채택한 Type에 생성자(Initializer)를 요구할 수 있다. 
 
  ```Swift
  protocol SomeProtocol {
      init(someParameter: Int)
  }

  class SomeClass: SomeProtocol {
      required init() {

      }
  }
  ```
  > Initializer의 Boey는 작성하지 않아도 되며, KeyWord와 Parameter만 정의하면 된다.   
  Class 에서 Protocol이 요구하는 Initializer를 채택하려면 `required` 식별자를 사용해야된다.   
  Struct 에서 Protocol이 요구하는 Initializer를 채택할때는 required 식별자가 따로 필요하진 않다.
---

<br>

## Extention
* `기존의 클래스, 구조체, 열거형, 프로토콜에서 새로운 기능을 추가하는 기능`
* Extention이 Type에 추가할 수 있는 기능
  * 연산 Type Property / 연산 Instance Property
  * Type Method / Instance Method
  * Initializer
  * 서브 스크립트
  * 중첩 타입
  * 특정 Protocol을 준수할 수 있도록 기능 추가
* 기존에 존재하는 기능을 Orverrid할 수 없다.
* 연산 Type Property 추가

  ```Swift
  /*
  extention SomeType {
      // 추가 기능
  }
  */
  extension Int {
      var isEven: Bool { // 짝쉬: true, 홀수: false
        return self % 2 == 0
      }

      var isOdd: Bool {
          return self % 2 == 1
      }
  }

  var number = 3
  number.isOdd   // true
  number.isEven  // false
  ``` 
  > Int Type의 어떠한 Instance에서도 사용이 가능하다.

* Type Method 추가
  ```Swift
  extension String {
      func convertToInt() -> Ing? {
          return Int(self)
      }
  }

  var string = "0"
  string.convertToInt()  //0
  ```
---
   
<br>

## Enum(열거형)
* `연관성이 있는 값들을 뫃아 놓은 것`
  ```Swift
  enum CompassPoint {
      case north
      case south
      case east
      case west
  }

  /* 열거형 변수 선언 */
  var direction = CompassPoint.east
  direction = .west
  ```
  > 각 항목은 그 자체가 고유값이며, 한 줄 나열도 가능하다.   
  컴파일러가 열거형의 이름을 추론할 수 있으므로 열거형 이름을 생략하고 `.내부 항복 이름`만으로도 사용이 가능하다.

* switch 구문과 함께 사용하는 enum
  ```Swift
  switch direction {
  case .north:
    print("north")

  case .south:
    print("south")

  case .east:
    print("east")

  case .west:
    print("west")
  }
  ```
  > switch 구문과 함께 사용하면 변수에 들어있는 enum 항목이 어떤 항목인지 비교할 수 있다.   
* 열겨형의 각 항목은 자체로도 값이지만, 항목의 `원시값`을 갖게 할 수 있다. 
  ```Swift
  enum CompassPoint: String {
      case .north = "북"
      case .south = "남"
      case .east = "동"
      case .west = "서"
  }
  ``` 
  > 특정 Type으로 지정된 값을 가진 수 있다.   
  Swift는 다른 프로그래밍 언어와 달리 다양한 Type을 원시값을 가실 수 있다.

* 초기화된 원시값을 사용하고 싶다면 `rowValue` 라는 Property를 통해 원시값을 가져올 수 있다.
  ```Swift
  var direction = CompassPoint.east
  direction = .west

  switch direction {
    case .north:
      print(direction.rowValue)

    case .south:
      print(direction.rowValue)

    case .east:
      print(dircetion.rowValue)

    case .west:
      print(direction.rowValue)    
  }
  ``` 
  > 서   
* 원시값을 가지고 열어형을 반환
  ```Swift
  let direction01 = CompassPoint(rawValue: "남")  // south
  ``` 

* 연겨형은 연관값을 가질 수 있다.(열거형 내의 항목이 자신과 연관된 값을 가진 수 있다.)
  ```Swift
  enum PhoneError {
    case unknown
    case batteryLow(String)  /* 연관값을 갖기 위해 항목 옆의 소괄호에 Type을 명시 */
  }

  let error = PhoneError.batteryLow("배터리가 곧 방전됩니다.")

  /* 연관값을 추출하기 위해 if or switch 문을 사용 */
  switch error {
  case .batteryLow(let message):  /* 소괄호 안에 연관값을 넘겨받을 상수 선언 */
    print(message)

  case .unknown:
    print("알 수 없는 에러입니다.")
  }
  ```  
  > 다른 항목이 연관값을 갖는다 하여 모두 연관값을 가질 필요는 없다.
