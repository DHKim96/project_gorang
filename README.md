# 고수의 냉장고: 고랭(GORANG)

![GORANG 로고](https://github.com/DHKim96/project_gorang/assets/156169335/706a5ed5-34d3-44cf-9cb0-9682ccc209bc)

## 프로젝트 정보
- **프로젝트 기간:** 2024년 4월 29일 ~ 2024년 6월 24일 ~ 

### 프로젝트 소개
고랭(GORANG)은 사용자가 자신의 냉장고를 효율적으로 관리할 수 있게 도와주는 서비스입니다.

주요 기능으로는 식품 관리, 소비기한 알림, 요리 레시피 추천, 커뮤니티 기능 및 쇼핑 기능이 포함되어 있습니다.

![image](https://github.com/user-attachments/assets/8b13440f-0185-459e-b642-14dad9fd8f70)

### 기획의도
![image](https://github.com/user-attachments/assets/7f39528c-c7a9-4102-9449-a7c0a70ce345)

![image](https://github.com/user-attachments/assets/2917b9da-1666-4038-8cb4-8b24112490b7)

### 주요 기능
1. **나의 냉장고 기능**
   - 식품명, 분류, 소비기한을 입력하고 DB화
   - 소비기한이 임박한 식품에 대한 알림
   - 입력한 식품들로 만들 수 있는 요리 추천 기능

2. **커뮤니티 기능**
   - 일반 게시판 및 레시피 게시판 기능
   - 사용자 간의 상호작용(댓글, 스크랩, 좋아요, 후기) 가능

3. **쇼핑 기능**
   - 식품 항목에 대한 판매자와 소비자 중개 기능
   - 관리자 모드에서 상품 관리 가능
   - 사용자가 상품을 스크랩하고 장바구니에 담아 구매 가능

### 배포
1. **URL**
   - https://www.gorang.store
   - 테스트용 계정
      - id: test@example.com
      - pwd: 1234

2. **Jenkins 기반의 CI/CD Pipeline 구축**
   - Git, jenkins, WAS(nginx-tomcat-AWS EC2), DB(AWS RDS)을 연결하여 자동 빌드/배포 프로세스를 구축하였습니다.

  
### 개발 환경

- **IDE:**
  [![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7?style=flat-square&logo=visual%20studio%20code&logoColor=white)](https://code.visualstudio.com/)
  <img src="https://img.shields.io/badge/eclipseide-2C2255?style=flat-square&logo=eclipseide&logoColor=white"/>

- **Frontends:**
  <img src="https://img.shields.io/badge/html5-E34F26?style=flat-square&logo=html5&logoColor=white"/>
  <img src="https://img.shields.io/badge/css3-1572B6?style=flat-square&logo=css3&logoColor=white"/>
  <img src="https://img.shields.io/badge/javascript-F7DF1E?style=flat-square&logo=javascript&logoColor=white"/>
  <img src="https://img.shields.io/badge/jquery-0769AD?style=flat-square&logo=jquery&logoColor=white"/>

- **Backends:**
  [![Java](https://img.shields.io/badge/Java-007396?style=flat-square&logo=java&logoColor=white)](https://www.oracle.com/java/)
  <img src="https://img.shields.io/badge/Spring-6DB33F?style=flat-square&logo=Spring&logoColor=white"/>
  <img src="https://img.shields.io/badge/Mybatis-000000?style=flat-square&logo=Mybatis&logoColor=white"/>

- **Database:**
  [![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=flat-square&logo=postgresql&logoColor=white)](https://www.postgresql.org/)

- **Collaborates:**
  [![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white)](https://github.com/)

### 사용 라이브러리 및 API (수정중)
- **라이브러리:**
   - 로깅: Log4j, SLF4J
   - JSON 처리: GSON
   - 이메일 전송: SMTP (JavaMailSender)
 
- **API**
   - 다음카카오 주소 API
   - Google/Kakao/Naver 로그인 API
   - Coolsms 핸드폰 문자인증 API
   - 스마트택배 배송조회 API
   - 공공데이터 식품 영양정보 API

---

## UI 구성 및 기능

### 로그인 및 회원가입
- **로그인**
   ![로그인](https://github.com/user-attachments/assets/c6a848a4-217b-49c1-ba90-c449bb1c061e)

   - 구현 기능
      - 로그인 버튼 클릭 시 API 요청 통해 이메일 등록 여부, 비밀번호 일치 여부 확인
      - 비밀번호는 BCryptPasswordEncoder 클래스를 통해 암호화되어 저장되기에 BCryptPasswordEncoder.matches 메소드를 통해 일치 여부 판단 후 최종적으로 로그인됩니다.

   - 추후 구현 예정
      - 로그인 상태 유지, 비밀번호 재설정 기능은 추후 구현 예정

- **소셜 로그인(EX.구글)**
   ![구글 로그인](https://github.com/user-attachments/assets/cfb47ae3-9d57-4bd2-bf22-84362add708f)
   - 구현 기능
      - 구글, 네이버, 카카오 API를 활용하여 OAuth2.0 방식의 소셜 로그인 기능
      - url 요청 시 CSRF 공격 방지 목적의 state 변수 추가하여 보안성을 확보하였습니다.

- **회원가입**
   ![회원가입](https://github.com/DHKim96/project_gorang/assets/156169335/588647c1-929b-48a7-b956-0e3b90c46db4)
   - 구현 기능
      - JavaMailSender 기반의 이메일 인증
         - 이메일란의 본인인증 버튼 클릭 시 API 요청 통해 이메일 중복 여부를 체크하고
         - SimpleMailMessage, JavaMailSender를 통해 6자리 난수 전송하여 인증 과정을 수행합니다.
         - 이때 클라이언트에서는 ASNCY과 AWAIT, PROMISE를 통해 과정의 순차성을 확보하였습니다.
      - coolSMS API 기반의 핸드폰 번호 인증
         - 전화번호란의 본인인증 버튼 클릭 시 API 요청 통해 전화번호 중복 여부를 체크하고
         - SDK 방식의 coolSMS 외부 API 활용하여 6자리 난수 전송하여 인증 과정을 수행합니다.
         - 이때 클라이언트에서는 ASNCY과 AWAIT, PROMISE를 통해 과정의 순차성을 확보하였습니다.
      - 다음카카오 주소 API 기반의 우편번호 및 주소 입력

### 메인UI
   ![고랭 메인페이지](https://github.com/DHKim96/project_gorang/assets/156169335/15a215c9-9d5e-4f19-8d72-56937f344145)
   - 구현 기능
      - SSE(Server Sent Event) 방식의 실시간 알림
         - 사용자의 작성글에 댓글/문의/리뷰가 달리거나 문의글에 답변이 달리는 등 이벤트가 발생할 시 서버에서 사용자에게 즉각적으로 알려주고자 SSE 방식의 실시간 알림 기능을 구현하였습니다. 해당 기능의 동작 과정은 아래와 같습니다.
         - 먼저 메인페이지의 클라이언트에서 EventSource를 통해 서버에 SSE 연결을 요청하도록 하였습니다.
         - 이후 상기한 이벤트(insert)가 발생할 경우 스프링 프레임워크의 ApplicationEventPublisher를 알림 객체 및 SseEmitter를 생성하는 이벤트를 발행하고 마찬가지로 서버의 @EventListener를 통해 해당 이벤트 내용을 전송하도록 하였습니다.
         - 이때 INSERT 관련 트랜잭션이 커밋된 후 이벤트 리스너가 실행되는 것을 보장하고자 @TransactionalEventListener을 사용하였습니다.
         - 추가적으로 NGINX를 사용하고 있는 배포 환경에서 SSE 방식의 실시간성을 위해서는 proxy buffering 설정을 OFF해야하지만, 타 API의 응답에 대해서도 버퍼링을 하지 않을 수 있음을 고려하여 nginx의 X-accel 기능을 활용, SSE의 응답 헤더에만 X-Accel-Buffering을 NO로 설정하여 선택적으로 proxy buffering을 동작하게 하여 효율성을 높였습니다.

   - 추후 구현 예정
      - SSE 실시간 알림 작동 시 헤더의 알림 버튼에 특정한 표시가 나타나게 하여 사용성을 높이고자 합니다.

### 커뮤니티
- **커뮤니티 메인**
   ![고랭_레시피_메인](https://github.com/user-attachments/assets/7417c35f-c3a8-4d4c-a6d4-1e452bd2f1e4)

- **레시피 게시글 목록**
   ![고랭_레시피_목록](https://github.com/user-attachments/assets/64aea99b-4d86-4af6-9fe0-7761a1aaca52)

- **레시피 게시글 상세**
   ![고랭_레시피_상세](https://github.com/user-attachments/assets/95078fad-b1ab-4ec6-8df9-9438dbea3c9c)

- **레시피 게시글 작성**
   ![고랭_레시피_작성](https://github.com/user-attachments/assets/689b36f7-a7df-4655-bb74-adb599a9ade9)

- **일반 게시글 목록**
   ![고랭_게시글_목록](https://github.com/user-attachments/assets/e7908b95-69f0-4583-89a6-e9340f3eb500)

- **일반 게시글 상세**
   ![고랭_게시글_상세](https://github.com/user-attachments/assets/096e4cc8-5e5b-4d01-b35a-5fb1f88620a3)

- **일반 게시글 작성**
   ![고랭_게시글_작성](https://github.com/user-attachments/assets/ab550293-de0e-44df-9728-b8f8d6bbd3e2)

- **일반 게시글 신고하기**
   ![고랭_게시글_신고](https://github.com/user-attachments/assets/32d785f9-a70a-4cc6-823c-5a3d64fd322a)

### 커머스
- **커머스 메인**
   ![고랭_상품_메인](https://github.com/user-attachments/assets/b880f027-279d-4de3-b7da-9ced5c045ee9)

- **상품 목록**
   ![고랭_상품_목록](https://github.com/user-attachments/assets/3757ac68-26a6-418b-8791-c996ce55829e)

- **상품 상세**
   ![고랭_상품_상세](https://github.com/user-attachments/assets/09e23ca3-043e-4411-882e-7a2287fda896)

- **상품 문의**
   ![고랭_상품_상세_문의](https://github.com/user-attachments/assets/c3e95256-4c5c-4a26-8aa7-8e64449f1ab7)

- **상품 주문**
   ![고랭_주문](https://github.com/user-attachments/assets/17fed2f6-1920-445f-be9e-8990ec3bed1c)

- **장바구니**
   ![고랭_장바구니](https://github.com/user-attachments/assets/5c0856ee-0e73-4a29-a7d5-c70847e634a5)

### 마이페이지
- **모두 보기(마이페이지 메인)**
   ![고랭_마이페이지_메인](https://github.com/user-attachments/assets/2c8576fc-b98a-4884-b7ab-f87af733ab98)

- **나의 게시글**
   ![고랭_마이페이지_나의게시글](https://github.com/user-attachments/assets/3d5174eb-9515-4902-b2d9-4c5201a6a50e)

- **댓글 & 후기**
   ![고랭_마이페이지_댓글_후기](https://github.com/user-attachments/assets/b78a376b-460f-4996-a50b-7076f4c8ef81)

- **문의**
   ![고랭_마이페이지_문의](https://github.com/user-attachments/assets/2b4efc0b-2ff3-45d7-86cd-e2cbdc5c12a2)

- **구매내역**
   ![고랭_마이페이지_구매내역](https://github.com/user-attachments/assets/3890d8f6-374a-4f43-a385-b8e2e7d77f05)

- **후기 작성**
   ![고랭_마이페이지_구매내역_후기](https://github.com/user-attachments/assets/6abe1177-529e-43b7-b20b-a71d87db9174)

- **배송 조회**
   ![고랭_구매내역_배송조회](https://github.com/user-attachments/assets/94b89fbf-b957-45a4-9072-e65e1ca0962d)

- **정보 수정**
   ![고랭_마이페이지_회원정보수정](https://github.com/user-attachments/assets/3aa0bafc-1882-40e4-b199-aeaea0f12e72)

- **회원 탈퇴 전 본인확인**
   ![고랭_마이페이지_회원탈퇴전확인](https://github.com/user-attachments/assets/1e2146a7-bf2b-44a8-a6f6-0f3dcd688bd5)

### 나의 냉장고
- **나의 냉장고 메인**
   ![고랭_마이페이지_나의냉장고_메인](https://github.com/user-attachments/assets/aab46002-4a6c-49e5-b3f4-794ec41461ca)

- **식재료 추가하기**
   ![고랭_마이페이지_나의냉장고_식재료_추가하기](https://github.com/user-attachments/assets/c841c198-0631-4157-87e9-225b4e68cf37)

- **식재료 영양성분 확인**
   ![고랭_마이페이지_나의냉장고_식재료_영양성분조회](https://github.com/user-attachments/assets/8af8cfe0-bf56-4b54-abdc-a326d9048e04)

- **레시피 추천받기**
   ![고랭_마이페이지_나의냉장고_레시피추천받기](https://github.com/user-attachments/assets/df6e9171-42da-473a-ab54-2e1623a84353)

### 관리자 페이지
- **상품 등록(관리자 페이지 메인)**
   ![고랭_관리자페이지_메인_상품등록](https://github.com/user-attachments/assets/dcc71779-85e5-4d9e-8c39-ea287326cc4c)

- **상품 관리**
   ![고랭_관리자페이지_상품관리](https://github.com/user-attachments/assets/24434a4a-55e4-4ee4-84ca-b9653d17bd38)

- **회원 관리**
   ![고랭_관리자페이지_회원관리](https://github.com/user-attachments/assets/baf8a1e3-09ce-4e02-876e-ed6b9dd1e488)

### 기타 UI
- **최근 본 목록**
   ![고랭_사이드바](https://github.com/user-attachments/assets/54881bb6-8b2a-4f07-999d-63d0ac8f0e67)

- **알림**
   ![고랭_알림](https://github.com/user-attachments/assets/8432fa03-64e0-49b5-84c0-855105d0f5bd)

---

## 팀 소개
- **김동현** (조장)
- **이동건** (형상 관리자)
- **함유철** (DB 관리자)
- **이강산** (일정 및 이슈 관리자)

### 팀원별 개발 내용
- **김동현**
  - 구매 페이지, 사이드바, 헤더, 푸터
  - 나의 냉장고, 구매내역, 쇼핑 상세, 로그인, 회원가입, 알림, SSE 실시간 알림
  - Google, Kakao, Naver 로그인 API, Coolsms 핸드폰 문자인증 API, 이메일 인증 SMTP

- **이동건**
  - 마이페이지 모두보기, 나의 게시글, 댓글 및 후기, 문의, 정보수정
  - 레시피 메인, 레시피 리스트, 쇼핑 메인, 쇼핑 리스트, 검색 페이지, 관리자 페이지
  - 다음카카오 주소 API

- **함유철**
  - 레시피 상세, 레시피 글쓰기, 레시피 수정
  - DB 설계 및 데이터 관리

- **이강산**
  - 게시판 메인, 게시판 상세, 게시판 글쓰기

