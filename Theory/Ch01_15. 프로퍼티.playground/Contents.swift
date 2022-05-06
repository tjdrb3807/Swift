import UIKit

// 클래스, 구조체 또는 열거형 등에 관련된 값을 뜻한다(인스턴스에 소속된 변수 및 속성)
// 저장 프로퍼티: 인스턴스의 변수 또는 상수
// 연산 프로퍼티: 특정 연산을 실행하는 결과값
// 타입 프로퍼티: 특정 타입에서 사용되는 프로퍼티


// 저장 프로퍼티
struct Dog {
    var name: String
    var gender: String
}

var dog = Dog(name: "gunter", gender: "Male")

print(dog)

