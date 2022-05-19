# Spotify 스타일 로그인 화면 구현하기

## OAuth
* 사용자 인증 방식에 대한 업계 표준
* ID/PW를 노출하지 않고 OAuth를 사용하는 업체의 API 접근 권한을 위임 받음
* 순서
  1. User가 App에 로그인 요청
  2. App의 Server가 Service Provier에게 권한 위임 요청을 보냄(Request Token)
  3. Service Provier에서 User에게 권한 위임 확인 요청
  4. User가 Service Provier에게 권한 위임 승인
  5. Service Provier가 App에 Access Token 전달 (App Server에서 관리)
  6. 로그인 완료

## firebase 연결하기
* firebase 홈페이지에서 프로잭트 생성
* Info-plist를 다운로드 받아 xCode Project에 Drag And Drop
* firebase SDK 추가
  * cocoapods로 설치
    * pod init
    * pod 'firebase/Auth'
    * arch -x86_64 pod install
  * workspace 파일로 프로잭트 진행
  * appDelegate 에서 
    ```Swift
    import Firebase

    func application(_ ...) {
        ...

        /* Firebase 초기화 */
        FirebaseApp.comfigure()
    }
    ``` 
    위 과정을 통해 생성한 Firebase 프로잭트와 xcode앱이 연결됐음을 확인할 수 있다.

## Firebase Auth 기능 구현 
* Firebase 홈페이지에서 Authentication 시작하기 
* 이메일 / 비밀번호 사용 설정

* tapNextButton Of EnterEmailViewController 에서 Firebase Authentication 구현
  * Firebase Auth 에서 제공하는 createUser 를 통해서 Firebase 인증 플랫폼에 전달할 수 있다. 
    * createUser 클로저 내에서 결과값을 받게된다.

* 동일한 email로 접속시 error 처리
* 로그인한 email이 MainViewController에 Present 됐을때 표현되는 기능 구현
* 로그아웃 기능 구현
* Google 로그인
  * pod 'GoogleSignIn'
  * 맞춤 RUL 스키마를 구성해야 한다. 
    * xcode.porject.TARGETS.info.URLTypes에서 반전된 클라이어트 id의 URL 스키마를 추가한다.
      * 스키마 값: firebase를 설치할 떄 추가했던 GoogleSevice-Info.plist의 REVERSED_CLIENT_ID
  * AppDelegate에서 import GoogleSignIn