# iOS
## UIKit
* `Cocoa Touch Framework`: iOS 개발 환경을 구출하기 위한 최 상위 Framework
  * `Foundation`: 가장 기본적인 데이터 타입, 자료구조, 각종 구조체, 네트워크 통신, 파일 관리 등 기본적인 프로그램의 중심을 담당.
  * `UIKit`: 사용자이 인터페이스를 관리하며 Event를 처리하는 것이 주 목적(MVC Pattern)
    > Apple의 MVC Pattern에서는 View 와 ViewController가 너무 밀접하여 ViewController가 View의 Life Cycle을 관리한다.   
    따라서 View와 ViewController를 분리하기 어려움에 따라 프로젝트의 규모가 커질수록 Controller가 비대해지고 내부 구조는 복잡하게 되어 유지보수가 힘들어지는 상황이 오게된다.   
    이러한 MVC Pattern의 문제점을 해결하기 위해서 `MVVC`등의 다양한 디자일 Pattern을 통해 MVC Pattern의 단점을 해결한다. 


## NotificaitonCenter
* `NotificationCenter는 등록된 Event가 발생하면 해당 Event들에 대한 행돌을 취한다.`
* EventBus라 생각하면 된다.
  * Event는 `Post` Method를 사용해서 Evnet를 전송한다.
  * Event를 받으려면 `Observer`를 등록해서 Post한 Event를 전달받을 수 있다.
 