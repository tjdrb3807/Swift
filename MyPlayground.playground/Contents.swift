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




