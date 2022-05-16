# URLSession을 통한 HTTP 통신
## URLSession
* `특정한 URL을 이용하여 데이터를 다운로드하고 업로드하기 위한 API`
* iOS에서 App과 Server간에 데이터를 통신하기위해 애플은 URLSession 이라는 API를 제공한다.
* iOS App은 하나 이상의 URLSession Interface를 생성한다
* URLSession은 request와 response를 기본 구조로 갖는다.
  * request: Server로 요청을 보낼 때 어떤 HTTP Method를 사용할 것인지 캐싱 정책을 어떻게 할것인지 등의 설정을 할 수 있다.
  * response: URL 요청에 응답을 나타내는 객체
* URLSession은 `URLSessionConfiguration`을 통해 생성하고, URLSession은 여러개의 `URLSessionTask`를 생성하여 이를 통해 Server와의 통신을 하고 `Delegate`를 통해 네트워크의 과정을 확인한다.

## URLSession의 종류

### 공유 세션(Shared Session)
* `URLSession.shared()`
* 싱글톤으로 사용 할 수 있다.
* 기본 요청을 하기 위한 Session
* 직접 만든 Session만큼 맞춤 설정을 한 수 없지만 쉽게 만들어 사용할 수 있디.

### 기본 세션(Default Session)
* `URLSession(configuration: .default)`
* 직접 원하는 설정을 할 수 있으며 캐쉬와 쿠키 등을 디스크에 저장할 수 있다.
* 순차적으로 데이터를 처리하기 위해 Delegate를 지정할 수 있다.

### 임시 세션(Ephemeral Session)
* `URLSession(configuration: .ephemeral)`
* 공유 세션과 비슷하지만 캐시, 쿠키, 사용자 인증정보를 디스크에 저장하지 않는다.
* 메모리에 올려서 Session을 연결하며, Session만료시 데이터가 사라진다.

### 백그라운드 세션(Background Session)
* `URLSession(configuration: .background()`
* 앱이 실행되지 않는 동안 백그라운드에서 컨텐츠 업로드 및 다운로드를 수행할 수 있다.

## URLSessionTask의 종류
* URLSession이 구성되면 URLSessionTask를 이용해서 각 Session 내의 작업을 추가할 수 있다.

### URLSessionDataTask
* 데이터 객체를 사용하여 데이터를 요청하고 응답 받는다. 
* 주로 짧고 빈번하게 요청하는 경우에 사용된다.

### URLSessionUploadTask
* 데이터 객체 또는 파일 형태의 데이터를 업로드하는 작업을 수행
* 앱이 실행되지 않았을 때 백그라운드 업로드를 지원한다.

### URLSessionDownloadTask
* 데이터를 다움로드 받아서 파일의 형태로 저장하는 작업을 수행
* 앱이 실행되지 않았을 때 백그라운드 다운로드를 지원한다.

### URLSessionStreamTask
* TCP/IP연결을 생성할 떄 사용

### URLSessionWebSocketTask
* Web Socket Protocol 표준을 통해 통신

## URLSession Life Cycle
1. Session Configuration을 결정하고, Session을 생성
2. 통신할 URL과 Request 객체를 생성
3. 사용할 Task 를 결정하고 그에 맞는 Completion Handler 나 Delegate 메소드를 장석
4. 해당 Task를 실행
5. Task 완료 후 Completion Handler 클로저가 호출됨(클로저 안에서 작업에 대한 결과 값을 받아볼 수 있다.)

---

## Codable Protocol

## URLSessionDataTask
    ```Swift
    let session = URLSession(configuration: .dafault)
    session.dateTask(with: url) { data, response, error in 
    
    }
    ```
    * completion handler 클로저 정의
      * 클로저 매개변수 data, response, error 
    * dataTask가 API를 호출하고 서버에서 응답이 오면 completion 클로저 handler가 호출된다.
    * 클로저 안에 data parameter에는 서버에서 응답받은 data가 전단된다.
    * response 파라미터에는 HTTP Header 및 상태코드와 같은 응답 메타데이터가 전달된다.
    * error 파라미터에는 요청이 실패하게 되면 에러 객체가 전달된다.
      * 요청에 성공하면 nil이 반한된다.

## JSONDecoder()
* JSON 객체에서 data 유형의 인스턴스로 디코딩하는 객체
* codable, decoable Protocol을 준수하는 사용자 정의 타입으로 변환시켜주는 객체
    ```Swift
    let decoder = JSONDecoder()
    let weatherInformation = decoder.decode(WeatherInformation.self, from: data)
    ```
    * 첫 번쨰 매개면수에는 JSON을 매핑시켜줄 codable protocol을 준수하는 사용자 정의 타입을 전달
    * from 매개변수에는 서버에저 전달받은 data

