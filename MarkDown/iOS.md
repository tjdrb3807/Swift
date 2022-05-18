 


## NotificaitonCenter
* `NotificationCenter는 등록된 Event가 발생하면 해당 Event들에 대한 행돌을 취한다.`
* EventBus라 생각하면 된다.
  * Event는 `Post` Method를 사용해서 Evnet를 전송한다.
  * Event를 받으려면 `Observer`를 등록해서 Post한 Event를 전달받을 수 있다.
 

 ## 기능 구현시 문제점
 * 일기장 상세 화면에서 삭제 또는 즐겨찾기가 토글 Delegate를 통해 ViewController의 indexPath와 isStar 여부를 전달하고 있는데 이렇게 되면 ViewController와 1:1로만 데이터를 전달할수 있다.
 * 일기장 화면에서 일기장 상세 화면으로 이동했을 때는 일기장 화면에만 delegate가 전달 수 있고, 즐겨찾기 화면에서 일기장 상세 화면으로 이동 했을 때는 즐겨찾기 화면에만 Delegate를 전달할 수 있다. 
 * 결론
   * deleaget를 전부 걷어네고 NotificationCenter를 이용해서 일기장 상세화면에서 삭제 또는 즐겨찾기 토글 행위가 발생하면, 일기장 화면과 즐겨찬기 화면에 이벤트가 모두 전달되도록 로직 변경
 
---
# Weater App
## UI 설계
1. 도시 검색 전에 날씨 정보를 가리기 위해 부모 Stack View를 Hidden 처리

## 기능 설계
1. 현재 날씨를 저장할 수 있는 구조체 생성, Codable Protocol 채택 
    ```Swift
    struct WeatherInformation: Codable {
      ...
    }
    ```
    * `Codable` Protocol: 자신을 변환하거나 외부 표현으로 변환할 수 있는 타입을 의미한다.
      * 여기서 외부 표혐이란 JSON과 같은 DATA Type을 의미한다. 
    * Codable을 Decodable과 Encodable Protocol을 준수하는 타입이다.
      * 즉 JSON Encoding과 Decoding이 가능하다.
2. 서버에서 전달받은 날씨 정보 JSON Data를 WeatherInformation Struct Type으로 Decoding 기능 구현
   * JSON Data 에서 필요한 데이터만 WeatherInformation Struct에 Property 설정
      * JSON 형태를 변환하고자 하면 기본적으로 JSON Type의 Key와 사용자가 정의한 Struct의 Property이름과 Type이 일치해야 한다. 
      * Key와 Property의 이름을 다르게 사요하고 싶다면, `CodingKeys`라는 String 타입의 열거형을 선언하여 `CodingKey Protocol을 준수`하게 해야한다.
3. URLSession을 이용해서 Current Weather API를 호추하여 도시의 날씨 정보를 가져오는 기능 구현
 
   ```Swift
   func getCurrentWeather(cityName: String) {
     guard let url = URL(".....") else { return }
     let session = URLSession(configuration: .default)
     /* CompletionHandler 클로저 정의 */
     session.dataTask(with: url) {  data, response, error in  /* 클로저 매개변수 */

     }
   }
   ``` 
   * dataTask가 API를 호출하고 서버에서 응답이 오면 Completion Handelr 클로저가 호출된다.
   * data parameter: 서버에서 응답받은 data가 전달
   * response parameter: HTTP Header 및 상태코드와 같은 응답 Meta Data가 전달
   * error parameter: 요청을 실패하게 되면 error객체가 전달(`요청에 성공하면 nil이 전달`)
4. completionHandler 클로저에서 응답받은 JSON 객체를 Decoding 기능 구현
   * JSONDecoder(): JSON 객체에서 데이터 유형의 인스턴스로 디코딩하는 객체
     * Decodable, Codable Protocol을 준수하는 사용자 정의 타입으로 변환시켜주는 것 
5. 서버에서 응답받은 데이터를 View에 표시하는 기능 구현
   * 네트워크 작업은 별소의 쓰게드에서 진행되며, 응답이 온다해도 자동으로 main 쓰레드로 돌아오지 않기 때문에 Completion 클로저 Handler에서 UI작업을 한다면 main 쓰에드에서 작업을 할 수 있도록 만들어주어야한다.
6. 잘못된 도시 이름 작성시 서버에서 가져온 error 객체를 알람으로 표시 기능 구현
   * error message JSON Data를 매핑할 수 있는 구조체 생성
   * error message를 알람으로 표현   

--- 
# COVID19 APP
## cocoapods
* Apple pletform에서 개발을 할 때 외무 라이브러리를 관리하기 쉽도록 도와주는 의존성 관리 도구
* 프로잭트에서 필요한 외부 라이브러리를 cocoapods을 통해 쉽게 관리 및 사용 

## UI설계
* rootViewController에 PieChart를 표시하는 UIView 추가
  * class: PieChartView
* PieChart에서 지역을 선택하면 선택된 지역의 발생 현황이 표시되도록 Static Table View를 사용하여 UI구성
  * Static Table View: 정적인 Table View를 구현하는데 사용되는 객체
  * 주로 설정처럼 정적인 리스트 형태의 UI를 구성할 떄 많이 사용된다. 
  * Static Table View 는 `UITableViewController`에서만 사용이 가능하다.
  * UITableView 를 TableViewController와 연결
    * Class: CovidDetailViewController
    * Subclass of: UITableViewController
  * TableViewController: Table View의 contents를 관리하거나 변화에 대응하는 delegate와 dataSource Protocol을 처음부터 채택하고있다.
    * 필수 메서드들이 주석처리 되어있다.
* Table View Controller안에 있는 Table View를 Static Table View로 변경
  * Contents: Static Cells 
  * Table View Section.Rows: 7
  * 7개의 Cell.Style: Right Detail