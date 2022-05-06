import UIKit

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoies() {
        print("speaker on")
    }
}

/*
class 클래스 이름: 부모 클래스 이름 {
    // 하위 클래스 정의
 }
 */
class Bicycle: Vehicle {
    var hasBasket = false
}

var bicycle = Bicycle()
bicycle.currentSpeed
bicycle.currentSpeed = 15.0
bicycle.currentSpeed


// 메서드 오버라이딩
class Train: Vehicle {
    override func makeNoies() {
        super.makeNoies()
        print("choo choo")
    }
}

let train = Train()
train.makeNoies()

// 프로퍼티 오버라이딩
class Car: Vehicle {
    var gear: Int = 1
    override var description: String {
        return super.description + "in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 30.0
car.gear = 2

print(car.description)

class AutometicCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10) + 1
        }
    }
}

let autometic = AutometicCar()
autometic.currentSpeed = 35.5
print("AutometicCar: \(autometic.description)")

