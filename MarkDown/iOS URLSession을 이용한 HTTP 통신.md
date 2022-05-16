# URLSession을 이용한 HTTP통신
## URLSession
* 특정한 URL을 이용하여 데이터를 다운로드하고 업로드하기 위한 API(App에서 Server와 통신하기 위해 제공하는 API)
* App은 하나 이상의 API URLSesscion Instance를 생성한다.
* `URLSessionConfiguration`: URLSession을 생성
* `URLSessionTask`: Server와 통신

## URLSession의 종류
### 공유 세션(Shared Session)
* `URLSession.shared()`
* 싱글톤으로 사용할 수 있으며 기본 요청을 하기위한 Session
* 직접 만들 Session만큼 맞춤 설정을 할 수는 없지만, 쉽게 만들어 사용할 수 있다.

### 기본 세션(Deafult Session)
* `URLSession(configuration: .default)`
* 공유 세선와 유사하게 작동하지만 맞춤 설정이 가능하다.
* 순차적으로 데이터를 처리하기 위해 delegate를 지정할 수 있다.

## 임시 세션(Ephemeral Sesison)
* `URLSession(configuration: .ephmeral)`


## 백그라운드 세션(Background Seddion)
* `URLSession(configuration: .background)`
* 앱이 실행하지 않는동안 백그라운드에서 컨텐츠 업로드 및 다운로드를 수행할 수 있다.

## URLSessionTask
* 각 Session 내에 작업을 추가
### URLSessionDataTask
* 데이터 객체를 사용하여 데이터를 요청하고 응답반는다.
* 주로 짧고 빈번하게 요창하는 경우에 사용된다.

### URLSessionUploadTask
* 데이터 객체 또는 파일 형태의 데이터를 업로드하는 작업을 수행한다.
* 앱이 실행되지 않았을때 백그라운드 없로드를 지원한다.

### URLSessionDownloadTask
* 데이터를 다운로드 받아서 파일의 현태로 저장 하는 작업을 수행한다.
* 앱이 실행중이지 않을 때는 백그라운드 다운로드를 지원한다.

### URLSessionStreamTask
* TCP/IP 연결을 연결을 생성할 떄 사용되는 Task

### URLSessionWebSocketTask
* WebSocket Protocol 표준을 통해 통신하는 Task

## URLSession Life Cycle
1. Session Configuration 을 결정하고, Session을 생성
2. 통신할 URL과 Request 객체를 생성
3. 사용할 Task 를 결정하고 그에 맞는 Completion Handler 나 Delegate 메소드를 작성
4. 해당 Task를 실행
5. Task 완료 후 Completion Handler 클로저가 호출이 됨

