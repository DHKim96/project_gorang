// ======================== SSE 알림 =======================================
function setEventSource(loginUser){
    // SSE 이벤트 스트림을 구독하기 위해 EventSource를 생성
    const eventSource = new EventSource('notifications/subscribe/' + loginUser);
  
    // 연결이 열렸을 때 발생하는 이벤트 핸들러
    eventSource.addEventListener("sse", (event) =>{
      console.log("SSE connection opened");
      console.log(event.data);
      const data = JSON.parse(event.data);
      (async () => {
        // 브라우저 알림
        const showNotification = () => {
          const notification = new Notification('SSE connection opened', {
            body: data.content
          });
  
          setTimeout(() => {
            notification.close();
          }, 10 * 1000);
  
          notification.addEventListener('click', () => {
            window.open(data.url, '_blank');
          });
        };
        
        // 브라우저 알림 허용 권한
        let granted = false;
  
        if (Notification.permission === 'granted'){
          granted = true;
        } else if (Notification.permission !== 'denied'){
          let permission = await Notification.requestPermission();
          granted = permission === 'granted';
        };
  
        // 알림 보여주기
        if(granted){
          showNotification();
        }
  
      })(); // async 함수 호출 추가(안해주면 작동안함)
    })
  
    // 서버에서 메시지를 수신할 때 발생하는 이벤트 핸들러
    eventSource.onmessage = function(event) {
        console.log("Received message: ", event.data);
        const notification = JSON.parse(event.data);
    };
  
    // 연결 오류가 발생할 때 발생하는 이벤트 핸들러
    eventSource.onerror = function(event) {
        console.error("SSE connection error", event);
        if (event.eventPhase === EventSource.CLOSED) {
            eventSource.close();
        }
    };
  }