/**
 * 
 * @param {*} element 
 */

document.addEventListener('DOMContentLoaded', () => {
  const loginUser = parseInt(document.querySelector("#main-container").getAttribute('data-loginUserNo'));
  setEventSource(loginUser);
  console.log("Notification permission status:", Notification.permission);
})

function moveDetailPage(element) {
  const type = element.getAttribute('data-type');
  const contentNo = element.getAttribute('data-no');

  if(type === 'recipe') {
    window.location.href = 'detailForm.re?recipeNo=' + contentNo;
  } else if (type === 'product') {
    window.location.href = 'detail.po?pno=' + contentNo;

  } else if (type === 'board') {
    window.location.href = 'detail.bo?boardNo=' + contentNo;

  }
}
// ========================= 전역 변수 ======================================
const ctx = document.querySelector("#main-container").getAttribute('data-contextPath');

// ======================== SSE 알림 =======================================
function setEventSource(loginUser){
  // SSE 이벤트 스트림을 구독하기 위해 EventSource를 생성
  const eventSource = new EventSource('notifications/subscribe/' + loginUser);

  // 연결이 열렸을 때 발생하는 이벤트 핸들러
  eventSource.addEventListener("sse", (event) =>{
    console.log("SSE connection opened");
    console.log(event.data);
    const data = JSON.parse(event.data);

    if ( data.notifyType === -1 ) return; // 더미데이터일 경우 표시하지 않음

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
          window.open(ctx + data.notifyUrl);
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


