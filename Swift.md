# Swift
## Ch01_04.상수와 변수    
* 상수: `let 상수명: 데이터 타입 = 값`   
    ```swift
    let a: Int = 100
    ```
* 변수: `var 변수명: 데이터 타입 = 값`   
    ```swift
    var b: Int = 100
    ```

## Ch01_05.기본 데이터 타입   
* Int   
    ```swift
    var someInt: Int = -100
    someInt = 100
    ```

## Ch01_10.Optional Binding   
* 명시적 헤제   
  * 강제 헤제(`!`: `옵셔널 강제 헤제 연산자`)   
    ```swift
    var number: Int? = 3

    print(number)   /* Optional(3) */
    print(number!)  /* 3 */
    ```  
    > 옵셔널 강제 헤제는 매우 위험한 방법: 값이 nil인 옵셔널을 강제 헤제할 경우 ERROR 발생으로 인한 프로그램 강제 종료   
    
  * 비강제 헤제(옵셔널 바인딩)_if문    
    ```swift 
    /*
    if 옵셔널을 추출해서 할당방을 변수나 상수 선언 {
        코드 블록
    } else {
        값 추출이 실패할 경우 실행
    }
    */
    var number: Int? = 3

    if let result = number {
        print(result)   /* 3 */
    } else {

    }
    ```
  * 비강제 헤제(옵셔널 바인딩)_guard문
    ```swift
    func test() {
        let number: Int? = 5

        guard let result = number else {return}
        print(result)   /* 5 */
    }

    test()
    ``` 
* 묵시적 헤제   
  * 컴파일러에 의한 자동 헤제   
  * 옵셔널의 묵시적 헤제(연산자에 의한 자동 헤제)       