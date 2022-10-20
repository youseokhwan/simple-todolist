## 📝 프로젝트 소개

해야하는 일을 자주 까먹으시나요?
잊지 않도록 편하고 쉽게 기록 해 보세요!

## 🔗 앱스토어 링크
[SimpleTodolist](https://apps.apple.com/kr/app/simpletodolist/id1639526629)

## ⚙️ 개발환경 및 라이브러리

<div align="center">
  <img src="https://img.shields.io/badge/Swift-5.7-red"/>
  <img src="https://img.shields.io/badge/Xcode-14.0-blue"/>
  <img src="https://img.shields.io/badge/RxSwift-6.5-purple"/>
  <img src="https://img.shields.io/badge/RxDataSources-5.0-orange"/>
  <img src="https://img.shields.io/badge/Realm-10.28-green"/>
  <img src="https://img.shields.io/badge/SnapKit-5.6-yellow"/>
</div>

## 📱 전반적인 UI
<div>
  <img src="https://user-images.githubusercontent.com/48671169/195978432-5c879269-e609-4fae-b877-d5ccaa4b6af7.png" width="333" height="700">
  <img src="https://user-images.githubusercontent.com/48671169/195978417-cec775f3-2c7d-409c-af05-03ce6dc8b858.png" width="333" height="700">
  <img src="https://user-images.githubusercontent.com/48671169/195978436-0ebd0882-1bd2-430f-9914-24305411184f.png" width="333" height="700">
</div>
 
## 🏛 아키텍쳐
<img width="1023" alt="아키텍처" src="https://user-images.githubusercontent.com/48671169/196898106-ec854de3-d7a7-4459-965b-13859425cd9e.png">

## 👊 기술적 도전
 
### 코드 기반 UI
- StoryBoard 및 Xib를 사용하지 않고 모든 UI를 코드 기반으로 그려주었습니다.
- SnapKit을 사용하여 AutoLayout을 구현하였습니다.

### RxSwift
- RxSwift, RxCocoa를 사용하여 UI 이벤트, 비동기 데이터를 간단하게 처리할 수 있도록 하였습니다.

### MVVM & Clean Architecture
- MVVM 패턴을 도입하여 View와 ViewController는 UI를 그리는 역할에 집중할 수 있도록 하였고, 데이터 입출력의 처리는 ViewModel이 수행하게 하였습니다.
- ViewModel의 비즈니스 로직 처리를 UseCase가 담당하여 처리를 하고 Storage에 대한 요청은 Repository가 담당하도록 계층을 나누었습니다.
- 용이한 테스트를 위해 의존성을 최대한 줄였습니다.
