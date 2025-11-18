# W3C Project
병원 시설 관리와 예약 기능을 갖춘 JSP 기반 웹 애플리케이션 병원 ERP 시스템

## 개요 👋
W3C 프로젝트는 병원 내 특수장비(초음파, MRI 등) 예약 과정에서 발생하는 비효율적인 수작업을 최소화하고,  
예약·시설·회원·직원 정보를 통합 관리할 수 있는 **병원 ERP 시스템**을 구축하는 것을 목표로 합니다.  

현재 일반 진료 예약은 전산으로 처리되지만,  
특수장비 예약은 간호사와 시설관리자 간의 수동 조율이 필요해 업무 부담이 증가하고  
비효율적인 커뮤니케이션 구조가 형성되는 문제가 있습니다.  

본 시스템은 이러한 문제를 해결하기 위해  
**실시간 시설 예약, 직원 및 회원 관리, 등급별 예약 우선순위 설정, 알림 연동 기능** 등을 포함하여  
병원 운영 효율성을 높이고 인력 낭비를 줄이는 것을 목표로 합니다.

## 🧱 기술 스택 (Tech Stack)
| 구분 | 사용 기술 |
|------|------------|
| Frontend | HTML, CSS, JavaScript, JSP |
| Backend | Java (Spring Boot, JDBC, MyBatis)|
| Server| Apache Tomcat |
| Database | Oracle |
| Tools | InteliJ, Git, GitHub |

## 🛠️ 설치 및 실행 (Installation & Run)
## 1. 프로젝트 클론
git clone [https://github.com/Team-W3C/W3C-Project.git]

## 2. 데이터베이스(Oracle) 설정
- Oracle 실행 후 데이터베이스 및 테이블 생성
- src/main/webapp/WEB-INF/classes/sql 폴더 내 SQL 스크립트 실행
- JDBC 연결 정보(application.properties) 수정

## 3. 웹 애플리케이션 실행
- 브라우저에서 접속
http://localhost:8001

## 📂 프로젝트 구조 (Directory Structure)
project/
 ├── src/main/java
 │   ├── com/project/config/
 │   ├── com/project/controller/     # Servlet 컨트롤러
 │   ├── com/project/model/dao/      # 데이터 접근 로직 (DAO)
 │   ├── com/project/model/mapper/
 │   ├── com/project/model/vo/       # VO (Value Object)
 │   ├── com/project/service/        # 비즈니스 로직
 │  
 ├── resources/                     # CSS, JS, 이미지
 ├── webapp/
 │   ├── WEB-INF/
 │   │   ├── views/                  # JSP 뷰 페이지
 │   └── index.jsp                   # 메인 페이지
 └── README.md

## 🌟 주요 기능 (Key Features)
✅ 회원가입 / 로그인 / 로그아웃 기능
✅ 게시글 등록, 조회, 수정, 삭제 (CRUD)
✅ Oracle DB 연동을 통한 데이터 관리
✅ MVC 패턴 기반 구조로 모듈화된 개발
✅ JSP include를 통한 공통 레이아웃 구성

## 💡 학습 포인트 (Learning Points)

- JSP & Spring Boot, MyBatis 기반 MVC 구조 설계 방법 학습
- JDBC를 통한 데이터베이스 연결 및 SQL 처리 로직 구현
- Tomcat 서버를 활용한 배포 및 실행 환경 이해
- JSP 내 JSTL / EL 사용으로 동적 페이지 구현
- git 협업 툴 학습

## 📂 Commit convention-

| prefix   | definition                                                      |
|----------|-----------------------------------------------------------------|
| feat     | 새로운 기능을 추가할 경우                                        |
| fix      | 기능을 수정하는 경우                                             |
| chore    | 프로젝트를 설정하는 경우                                         |
| ui       | UI, 스타일 관련 파일 추가 및 수정                               |
| build    | 빌드 관련 수정                                                  |
| ci       | CI 관련 설정 수정                                               |
| docs     | 문서 파일 추가 및 수정                                           |
| style    | 코드 스타일, 포맷팅에 대한 수정                                 |
| refactor | 기능의 변화가 아닌 코드 리팩터링 (예: 변수 이름 변경)           |
| test     | 테스트 코드 추가/수정                                           |
| release  | 버전 릴리즈                                                      |

## 깃 이슈
feat: 로그인 구현 기능

## 깃 브랜치
feat/1-login-feature

## 깃 커밋
feat: 로그인 구현 기능 #1

## 팀원 소개

| 이름 | 포지션 | Contact |
| --- | --- | --- |
| 최승호 | 조장 | dreamdpsh@gmail.com |
| 신동호 | DB 관리자 | a1@gmail.com |
| 조치호 | DB 관리자 | chiho3898@gmail.com |
| 신한서 | 이슈 관리자 | hanseo.lab@gmail.com |
| 이채진 | 일정 관리자 | jinking0930@gmail.com |
| 장원석 | 형상 관리자 | jang1suk9155@gmail.com |

