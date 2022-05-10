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