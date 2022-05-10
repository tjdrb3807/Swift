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

<br>

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
<br>

# Extention
* 