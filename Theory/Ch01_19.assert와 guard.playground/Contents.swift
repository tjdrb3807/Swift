import UIKit

// assert:
// 1.특정 조건을 체크하고, 조건이 성립되지 않으면 메세지를 출력 하게 할 수 있는 함수
// 2.assert함수는 디버깅 모드에서만 동작하고 주로 디버깅 중 조건의 검증을 위하여 사용된다.

var value: Int = 0
assert(value == 0)

value = 2
//assert(value == 0, "값이 0이 아닙니다.")

// guard문
// 1.뭔가를 검사하여 그 다음에 오는 코드를 실행할지 말지 결정하는 것
// 2.guard 문에 주어진 조건문이 거짓일 때 구문이 실행됨
/*
 guard 조건 else {
    // 조건이 false이면 else 구문이 실행되고
       return or throw or break 를 통해 이 후 코드를 싱행하지 않도록 한다.
 */

func guardTest(valeu: Int) {
    guard valeu == 0 else {return}
    
    print("안녕하세요")
}

guardTest(valeu: 0)



