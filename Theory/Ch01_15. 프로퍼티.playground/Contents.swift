import UIKit

// 클래스, 구조체 또는 열거형 등에 관련된 값을 뜻한다(인스턴스에 소속된 변수 및 속성)
// 저장 프로퍼티: 인스턴스의 변수 또는 상수
// 연산 프로퍼티: 특정 연산을 실행하는 결과값
// 타입 프로퍼티: 특정 타입에서 사용되는 프로퍼티


// ------------------------------- 저장 프로퍼티 ------------------------------- //
// 구조체, 클래스 에서만 사용 가능

struct Dog {
    var name: String
    let gender: String
}

var dog = Dog(name: "gunter", gender: "Male")

print(dog)

// 저장 프로퍼티의 값 변경
dog.name = "퀀태완"


let dog02 = Dog(name: "coco", gender: "FMale")

// 상수로 선언된 구조체 인스턴스의 저장 프로퍼티 변경
// dog02.name = "maru" (ERROR)  -> 구조체는 값타입이다.
// 구조체 인스턴스를 상수로 선언하면 내부 프로퍼티들 모두 상수로 선언이 된다.

// 상수로 선언된 클래스 인스턴스의 저장 프로퍼티 병경
class Cat {
    var name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let cat = Cat(name: "maru", age: 3)
// 클래스는 참조타입 이므로 클래스 인스턴스를 상수로 선언해도 저장 프로퍼티의 값을 변경할 수 있다.
// 단, 상수로 선언된 저장 프로퍼티의 값은 변경할 수 없다.
cat.name = "coco"
print(cat.name)


// ------------------------------- 계산 프로퍼티 ------------------------------- //
// 구조체, 클래스, 열거형 에서 사용 가능
// 값을 직접적으로 저장하지 않는 대신에 Getter와 Setter를 사용해서 다른 프로퍼티와 값들을 접근할 수 있다.

struct Stock {
    var averagePrice: Int
    var quantity: Int
    var purchasePrice: Int {
        get {
            return averagePrice * quantity
        }
        
        set(newPrice) {  // set 설정시 parameter name을 설정하지 않으면 newValue라는 변수명을 default로 사용하게 된다.
            averagePrice = newPrice / quantity
        }
    }
}

var stock = Stock(averagePrice: 2300, quantity: 3)
print(stock)

stock.purchasePrice
stock.purchasePrice = 3000
stock.averagePrice

// 프로퍼티 옵저버: 프로퍼티 값의 변화를 관찰하고 반영(새로운 값이 기존의 값과 같더라고 프로퍼티 옵저버는 실행된다.)
// 프로퍼티 옵저버를 사용할 수 있는 경우
// 저장 프로퍼티
// 오버라이딩이 된 저장 계산 프로퍼티


// 저장 프로퍼티가 사용되는 경우
class Account {
    var credit: Int = 0 {
    
        //소괄호 이름지정
        willSet {
            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
        }
    
        didSet {
            print("잔액이 \(credit)원에서 \(oldValue)원으로 변경되었습니다.")
        }
    }
}

var account = Account()
account.credit = 1000


// ------------------------------- 타입 프로퍼티 ------------------------------- //
// 인스턴스 생성 없이 객체 내의 프로퍼티에 접근 간능
// 저장 프로퍼티와 연산 프로퍼티에서만 사용이 가능하다.

struct SomeStructure {
    static var storedTypeProperty = "Some value."  // 스토어
    static var computedTypeProperty: Int {  // 컴퓨티드
        return 1
    }
}

SomeStructure.computedTypeProperty
SomeStructure.storedTypeProperty
SomeStructure.storedTypeProperty = "hello"
SomeStructure.storedTypeProperty





