 


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
 