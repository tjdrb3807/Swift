import UIKit

// 클래스와 구조체의 공통점

// 1.값을 저장할 프로퍼티를 선언할 수 있다.
// 2.함수적 기능을 하는 메서드를 선언할 수 있다.
// 3.내부 값에 . 을 사용하여 접근할 수 있다.
// 4.생성자를 사용해 초기 상태를 설정할 수 있다.
// 5.extension을 사용하여 기능을 확장할 수 있다.
// 6.Protocol을 채택하여 기능을 설정할 수 있다.

// 클래스와 구조체의 차이점

// 클래스
// 1.참조타입
// 2.힙 영역에 할당 -> ARC로 메모리 관리
// 3.상속이 가능
// 4.타입 캐스팅을 통해 런타임에서 클래스 인스턴스의 타입을 확인할 수 있다.
// 5.deinit을 사용하여 클래스 인스턴스의 메모리 할당을 해제할 수 있다.
// 6.같은 클래스 인스턴스를 여러 개의 변수에 할당한 뒤 값을 변경 시키면 모든 변수에 영향을 준다(메모리가 복사)

// 구조체
// 1.값 타입
// 2.구조체 변수를 새로운 변수에 할당할 떄마다 새로운 구조체가 할당된다.
// 2_1.같은 구조체를 여러 개의 변수에 할당한 뒤 값을 변경시키더라도 다른 변수에 영향을 주지 않느다.(값 자체를 복사)

class SomeClass {
    var count: Int = 0
}

struct SomeStruct {
    var count: Int = 0
}

var class01 = SomeClass()
var class02 = class01
var class03 = class01

class03.count = 2
class01.count

var struct01 = SomeStruct()
var struct02 = struct01
var struct03 = struct01

struct02.count = 3
struct03.count = 4

struct01.count
struct02.count
struct03.count


