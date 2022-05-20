# Local Notification
* App 내부에서 자체적으로 만들 특정 Message를 전달하는 알림

## Local Notification의 구성
* 로컬 알림을 보내기 위해서는 알림 요청 즉, `UNNotificationRequest`를 작성해야한다. 
  * `UN`: UserNotification
* UNNotificationRequest를 작성하기 위한 필수적인 세가지 내용 작성
  * `Identifier`: 각각의 요청을 구분할 수 있는 식별자
    * 중복되지 않고 고유의 값을 갖는 UUID를 사용하는 것 이 일반적
  * `Content`: 알림에 표시할 내용을 정의
    * 알림에 표시된 Title, Contents, Sound, 뱃지에 표시된 내용을 String으로 직접 입력
  * `Trigger`: 알람을 어떤 기준에서 발송할 것인가 하는 조건은 작성
    * UN`Calendar`Notification`Trigger`: 날력/날짜 기준
    * UN`TimeInterval`Notification`Triger`: 시간 간격 기준
    * UN`Location`Notification`Triger`: 사용자의 위치 기준
* 작성한 UNNotificationRequest를 `NotificationCenter`에 전송
  * NotificationCenter에 보관된 UNNotificationRequest들은 Trigger의 조건에 따라 Client에게 전송