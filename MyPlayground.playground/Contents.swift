import UIKit

// --------------------------------------- Ch01_04.상수와 변수 --------------------------------------- //

// 상수
// let 상수명: 데이터 타입 = 값
let a: Int = 100

// 변수
// var 변수명: 데이터 타입 = 값
var b: Int = 100
b = 300


// --------------------------------------- Ch01_05.기본 데이터 타입 --------------------------------------- //

// Int
var someInt: Int  = -100
someInt = 100

// UInt
var someUInt: UInt = 200
// someUINt = -100 ERROR

// Float
var someFloat: Float = 1.1
someFloat = 1
print(someFloat)

// Double
var someDouble: Double = 1.1
someDouble = 1

// Bool
var someBool: Bool = true
someBool = false

// Character
var someCharactre: Character = "가"
someCharactre = "A"
someCharactre = "😀"
// someCharacrter = "문자열" ERROR

// String
var someString: String = "안녕하세요 🥰"

// 타입 추론
// 컴파일러가 타입을 추론하므로 생략이 가능하다.
var number = 10

// --------------------------------------- Ch01_06.컬렉션 타입 --------------------------------------- //
// Array: 데이터 타입의 값들을 순서대로 저장하는 리스트
// Dictionary: 순서없이 키(Key)와 값(Value) 한 쌍으로 데이터를 저장하는 컬렉션 타입
// Set: 같은 데이터 타입의 값을 순서 없이 저장하는 리스트(중복을 허용하지 않는다.)


// 기본적인 Array 생성방법
var numbers: Array<Int> = Array<Int>()
// Array<Int>에 데이터를 추가
numbers.append(1)
numbers.append(2)
numbers.append(3)

// Array는 각 요소의 Index로 접근할 수 있다.
numbers[0]
numbers[1]
numbers[2]

numbers.insert(4, at: 2) // 중간에 삽입이므로 기존 요소는 뒤로 밀리게 된다.
numbers

numbers.remove(at: 0)
numbers

// 다른 방법으로 Array 생성
var names01 = [String]()
var names02: [String] = []  //이러한 축약된 형태를 선호한다.
var numbers02: [Int] = []


// 기본적인 Dictionary 생성방법
var dic: Dictionary<String, Int> = Dictionary<String, Int>()
// 축약된 Dictionary 생성방법
var dic01: [String: Int] = [:]
// 초기값이 설정된 Dictionary 생성방법
var dic02: [String: Int] = ["전성규": 29]
// Dictionary에 값을 넣는 방법
dic02["김성재"] = 29
dic02["이민영"] = 29
dic02


// Dictionary의 Key에 해당하는 Value 변경
dic02["전성규"] = 1
dic02

// Dictionary의 Key에 해당하는 Value 제거
dic02.removeValue(forKey: "이민영")
dic02

// 기본적인 Set 생성방법
// Set: 순서가 없고 유일성을 보장하는 컬렉션 타입
// Set는 축약형 생성이 별도로 존재하지 않는다.
var set: Set = Set<Int>()

// Set에 값을 추가
set.insert(10)
set.insert(20)
set.insert(30)
set.insert(30)  // 똑같은 값을 추가하여도 중복된 값은 하나만 저장된다.
set

set.remove(20)
set

// --------------------------------------- Ch01_07.함수 사용법 --------------------------------------- //
// 함수: 작업의 가장 작은 단위이자 코드의 집합
// 반복적인 프로그래밍을 피하기위함
// Best: 하나의 기능을 하나의 함수로!!!
/**
 func 함수명(파라미터 이름: 데이터 타입) -> 반환 타입 {
    return 반환 값
 }
 */

func sum(a: Int, b: Int) -> Int{
    return a + b
}

sum(a: 3, b: 2)

func hello() -> String{
    return "hello"
}

hello()

func printName() -> Void{  // return값이 없을 경우 -> Void 생략가능
    
}

// 합수의 파라미터 기본값 사용
func greeting(fried: String, me: String = "성규") {
    print("Hello, \(fried)! I'm \(me)")
}

greeting(fried: "성재")


//전달인자 레이블을 사용해서 함수를 정의
/*
 func 함수 이름(전달인자 레이블: 매개변수 이름: 매개변수 타입, 전달인자 레이블: 매개변수 이름: 매개변수 타입...) -> 반환 타입 {
    return 반환 값
 }
 */

func sendMessage(from myName: String, to name: String) -> String {
    return "hello \(name)~ I'n \(myName)"   //문자열 안에서 변수 사용: \(변수 이름)
}

// 전달인자 레이블을 사용하면 함수 사용자 입장에서 매개변수의 역할을 좀더 명확하게 파악할 수 있어 코드 가독성이 높아진다.
sendMessage(from: "Gunter", to: "Json")

// 전달인자 레이블을 사용하지 않고싶다면 와일드카드 식별자 사용
func sendMessage01(_ name: String) -> String {
    return "Hello~ \(name)"
}

sendMessage01("Jeon Seong Gyu")

// 매개변수로 몇개의 값이 들어올지 모를 경우 가변 매개변수를 사용한다.
// 가변 매개변수는 0개 이상의 값을 받을 수 있으며, 가변 매개변수로 들어온 값들은 배열처럼 사용이 가능하다.
// 함수마다 가변 매개변수는 하나만 가질 수 있다.
func sendMessage02(me: String, friends: String...) -> String {
    return "Hello \(friends)! I'm \(me)"
}

sendMessage02(me: "성규", friends: "성재", "민영")

// --------------------------------------- Ch01_08.조건문 --------------------------------------- //
// 조건문: 주어진 조건에 따라서 에플리케이션을 다르게 동작하도록 하는 것이다.
/*
 if 조건식 {
    실행할 구문
 }
 */
let age = 20

if age < 19 {
    print("미성년자 입니다.")
}

/*
 if 조건신 {
    조건식이 만족하여 해당 구문 실행
 } else {
    만족하지 않으면 해당 구문 실행
 }
 */
if age < 19 {
    print("미성년자 입니다.")
} else {
    print("성인 입니다.")
}

/*
 if 조건식1 {
    조건식이 만족하여 해당 구문 실행
 } else if 조건식2 {
    조건식2이 반족하여 해당 구문 실행
 } else {
    아무 조건식도 만족하지 않으면 해당 구문 실행
 }
 */
let animal = "cat"

if animal == "dog" {
    print("강아지 사료주가")
} else if animal == "cat" {
    print("고양이 사료주기")
} else {
    print("해당하는 동물 사료가 존재하지 않습니다.")
}

// 특정 값 을 사용한 비교패턴
/*
 switch 비교대상 {
    case 패턴1:
        //패턴1 일치할 때 싱행되는 구문
    case 패턴2, 패턴3:
        //패턴2, 패턴3 일치할 때 실행되는 구문
    default:
        //어느 비교 패턴과도 일치하지 않을 때 실행되는 구문
 }
 */
let color = "red"

switch color {
case "blue":
    print("파란색 입니다.")
    
case "green":
    print("초록색 입니다.")
    
case "yellow":
    print("노랸색 입니다.")
    
default:
    print("찾는 색상이 존재하지 않습니다.")
}

// 범위연산자를 사용한 비교 패턴
let temperature = 100

switch temperature {
case -20...9:
    print("겨울 입니다.")
    
case 10...14:
    print("가을 입니다.")
case 15...25:
    print("봄 입니다.")
case 26...35:
    print("여름 입니다.")
default:
    print("이상 기온입니다.")
    
}


// --------------------------------------- Ch01_09.반복문 --------------------------------------- //
// 반복문: 반복적으로 코드가 실행되게 만드는 구문

// for-in: 일정 회수만큼 특정 구문을 반복
/*
 for 루프 상수 in 순회 대상 {
    // 실행 할 구문..
 }
 */
// 루프 상수: 구문이 반복될 때 마다 순회대상이 포함된 아이템을 넘겨받아 실행 블록 내에서 사용할 수 있게 하는 역할(실행 블록 내부에서만 사용 가능)
// 순회 대상: Set, Array, Dictionary, 범위 데이터, String 등의 타입이나 변수 사용 가능
for i in 1...4 {
    print(i)
}

let array = [1,2,3,4,5]

for i in array {
    print(i)
}

// while: 주어진 조건이 false 가 될 떄 까지 반복 실행
/*
 while 조건식 {
    // 실행할 구문
 }
 */

var number01 = 5

while number01 < 10 {
    number01 += 1
}

number01

// repeat-while
/*
 repaet {
    // 실행할 구문
 } while 조건식
 */
var x = 6

repeat {
    x += 2
} while x < 5

print(x)
            
// --------------------------------------- Ch01_10.Optional --------------------------------------- //
// 옵셔널: 값이 있을 수도 있고 없을 수도 있다.
// var name: String = "안녕하세요"
// var name: String = ""  <- 빈 문자열이라는 값을 가지고 있는 것이다.
// var name: String? = nil <- 값이 없는 경우
// var number: Int = 7
// var number: Int = 0
// var number: Int? = nil

// 아무 변수에나 nil을 지정할 수 없다.
// 값이 있을 수도 있고 없을 수도 있는 변수를 정의할 때 타입 뒤에 ?를 붙여야 된다 -> 이렇게 정의한 변수를 Optional 이라 한다.
// 기본적으로 Optional에 초기값을 지정하지 않으면 초기값은 nil이다.
// Swift는 안정성이 장점인 언어로서 값이 없을수도 있는 변수에 Optional을 사용한다면, 값이 없는 변수에 접근을 해도 타 프로그램처럼 NullPointException이 발생하지 않고 접근할 수 있다.

// default == nil
var name: String?

// Optional Type에 일반값을 넣을 수 있다.
var optionalName: String? = "성규"
print(optionalName)  // 포장되어있는 Optional 변수는 일반 변수화 결합이 불가능하다.

//var requiredName: String = optionalName




