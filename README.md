# Casual Conversation 프로젝트

[<img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F69a38380-1115-4931-a927-6fa25b595692%2Fappstore.png?table=block&id=48bd959c-7719-4ac1-b0cb-d4e4d9b7f7a7&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width="150" height="150">](https://apps.apple.com/kr/app/id1642134370/) [<img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F3f389223-44b3-43f4-aba5-852e9bdae806%2Fpngwing.com.png?table=block&id=ac150090-d883-4de6-9198-f40f378d8d6f&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=195 height=75>](https://apps.apple.com/kr/app/id1642134370/) 

***잊지말고 녹음부터 하세요!***

***항상 회화 순간을 녹음해두었다가  
모르는 단어와 만들지 못한 문장을 학습하세요!***

## 📱 앱 소개
영어회화를 녹음하고 녹음된 내용을 다시 들으며, 몰랐던 단어와 만들지 못한 문장을 기록하고   
기록한 단어나 문장을 다시 만들어보는 기회를 제공하는 기록앱입니다.    
[인스타그램 홍보/문의 페이지](https://www.instagram.com/casualconversation_ccrecorder/)  [앱스토어](https://apps.apple.com/kr/app/id1642134370/)  

## 🗂 프로젝트 소개
팀원 : 2명 (iOS 개발 1명, ProductManger 1명)  
기간 : 22.06.17 ~ 22.09.17 `v1.0.0 출시` / 09.19 `v1.1.0 업데이트` ~    

![](https://img.shields.io/badge/Target_iOS-15.0~-green) ![](https://img.shields.io/badge/Swift-5.6-orange) ![](https://img.shields.io/badge/Xcode-13.4-blue) ![](https://img.shields.io/badge/SwiftUI-3.0-puple) 

## 🥇 프로젝트팀 소개
### Team MarCoda
|<img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F1cba71b5-edd1-4247-9048-4230712e2d3d%2FProfile_1.jpeg?table=block&id=e17e3b5c-cbdd-4196-8832-38e6e1083432&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=200 height=200>|<img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F8e197c5f-03be-4e4a-a777-a0e5468a1c5f%2FCoda__Design.jpg?table=block&id=458a1cfe-8d8b-4fb4-9bf9-80e5ab47ef20&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=200 height=200>|
|:---:|:---:|
|iOS Development/Team Leader|ProductManger/Design|
|김용우 [@keeplo](https://github.com/keeplo) |김찬우 [@dacodaco](https://github.com/dacodaco) |

## 🛠 기술 스택

### Tuist
* `tuist generate` 이용해서 Xcode 생성 - Merge Conflict 해결
* AppTarget - Dependency Targets 이용해서 모듈화 
    * Data, Domain, Presentation Layer 분리 + *Common Layer (CCError, Protocols)*
    * Code [Project.swift](https://github.com/PSE-Applications/CasualConversation/blob/main/CasualConversation/Project.swift)
    <details><summary>Project Navigation Image</summary><div markdown="1">
        <img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F6d2697d7-39d3-4261-a697-401af26fc6ba%2FUntitled.png?table=block&id=8aa99e8c-0267-4f7a-a0f8-a82514c91098&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=540 height=840>
    </div></details>

### Clean Architecture (iOS) + MVVM
* 프로젝트 구조의 계층을 나누어 관심사를 분리
    * 프레임워크 독립적 
        > ex)`AVFAudio` 프레임워크는 AudioService 에서만 사용
    * 테스트 용이
        > ex) 각 Layer(Target) 독립된 테스트 구현
    * UI 독립적
        > ex) Presentation Layer 독립 구현 (`public` 외부 모듈 접근, `internal` 모듈 내부)
    * DB 독립적
        > ex) Business Logic과 별개로 동작 (CoreData, FileSystem)
    * 외부 기능 독립적
        > ex) 필요 시 Network Layer 분리 구현 가능 ([iOS-CleanArcitecture-MVVM 예제 참고](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM)) 
* UML
    [<img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Fa260c9d0-92ce-4204-ba46-362ccc032452%2FUntitled.png?table=block&id=89cf9c58-2c2f-4a3c-b381-af32fcdfc2c9&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2">](https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Fadb23e9e-410a-4708-9966-d500cd519f00%2F%25EC%258A%25A4%25ED%2581%25AC%25EB%25A6%25B0%25EC%2583%25B7_2022-09-20_%25EC%2598%25A4%25ED%259B%2584_8.35.18.png?table=block&id=02f76787-d807-46f1-a4d8-6e215c076918&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2)

> Reference by   
> [The Clean Architecture by Robert C.Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)   
> [Clean architecture series — Part 3 _ The Cone](https://pereiren.medium.com/clean-architecture-series-part-3-a0c150551e5f)   
> [iOS-CleanArcitecture-MVVM](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM)   

### Apple Framework
#### Combine
* Combine 이용한 데이터 바인딩 Flow 적용
    > ex1) (Data) FetchedList -> (Domain) DataSource -> (Presentation) List  
    > ex2) (Domain) CurrentTime -> (Presentation) CurrentTime
* `.assing(to:)` 활용한 @Published 데이터 바인딩
    > `@Published` - `Published<Type>.Publisher` 연동

#### SwiftUI
AppDelegate, SceneDelegate 없는 SwiftUI Project 형태로 구현   
Code [CasualConversationApp.swift](https://github.com/PSE-Applications/CasualConversation/blob/main/CasualConversation/Targets/CasualConversation/Sources/CasualConversationApp.swift)

#### AVFAudio
* AVAudioSession
* AVAudioRecorder
* AVAudioPlayer

#### CoreData
* NSManagedObject
#### FileSystem
* FileManager

### Dependency
#### UnitTest (BDD)
* Quick
* Nimble

## ⚙️ 기능 소개 with ScreenShots
### 녹음기능
- 원하는 시점 북마크를 할 수 있어요, 녹음물에 제목, 대화 주제, 참여자 등 정보를 입력할 수 있습니다.  
<img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F1bba3dab-bb63-4d54-b19a-67417e256981%2FiphoneX_2.jpg?table=block&id=66157add-ad3e-4fad-8a1c-a482e7af85f5&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=200> <img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Ff7152056-1810-4aff-a654-e91c6e3bbd32%2FSimulator_Screen_Shot_-_iPhone_12_Pro_-_2022-09-20_at_23.02.32.png?table=block&id=6c8fcc29-bf03-4b78-86d3-f769d167263e&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=200> <img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Fe977bfae-17f0-4d19-8e64-5c785cf55f10%2FIMG_0493.png?table=block&id=756ba0b3-7c94-497b-b0e1-21459643ad05&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=200>
- 녹음물을 관리 할 수 있습니다.  
<img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Fed89030f-01ef-4021-8fb3-fd8634196f12%2FIMG_0500.png?table=block&id=70f4f368-56b7-4d60-934e-45422103a0ca&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=200> <img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F23e5e230-d5ba-49e9-9d62-970f17aeb64c%2FIMG_0501.png?table=block&id=9a1ab841-7839-4966-b697-91e171a62953&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=200> <img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F390d3e8e-f112-4cc3-8dee-c338d7f97f77%2FSimulator_Screen_Shot_-_iPhone_12_Pro_-_2022-09-20_at_23.52.08.png?table=block&id=88939fb9-956f-495e-bc59-3c274654b83f&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=200>
### 재생기능 및 기록하기, 복습하기
- 녹음물을 다시 들으며 단어, 문장을 기록할 수 있습니다.  
<img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F0920ca15-b966-4dcb-8dac-27cc7eca816f%2FiphoneX_3.jpg?table=block&id=a2efd32c-a350-4e6a-b53d-f00038bbe0ba&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=200> <img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F416cbbfc-1c1b-47d9-991b-8c60c1a9c437%2FSimulator_Screen_Shot_-_iPhone_12_Pro_-_2022-09-20_at_23.13.33.png?table=block&id=11098337-2bd4-4685-92ca-99acce510ccc&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=200> <img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F44deeef1-0dbe-4b2a-9ef0-8a7f3076971d%2FIMG_CE3BB51DA65D-1.jpeg?table=block&id=1c1a6bf0-4de1-4e14-928d-7a01568fa61c&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=200>
- 기록한 단어, 문장 데이터를 관리하고 영한/한영 번역 만들기를 할 수 있습니다.  
<img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F002e68f5-17af-4138-9e70-be9fbe614a1a%2FiphoneX_5.jpg?table=block&id=a038a03e-ef8b-4add-af4e-89ae3f89d1d4&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=200> <img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F9b23c486-8769-4e8c-a615-891d38acb67f%2FiphoneX_4.jpg?table=block&id=daf94729-8a0f-4e5a-a27b-0c7bf1f22e17&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=200> <img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Fe5ca2b7b-f9a2-434c-b8dd-793b0325ebca%2FSimulator_Screen_Shot_-_iPhone_12_Pro_-_2022-09-20_at_23.19.11.png?table=block&id=0a1228f8-2ad2-4ce7-b1e4-de7d6fcc3d69&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=200>
### 설정 및 정보
- 넘어가기 기능, 다크모드, 화면 자동잠금 등 앱 설정을 관리할 수 있습니다.  
<img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F94fe421a-d8e7-485d-9a50-7447bf2418e4%2FSimulator_Screen_Shot_-_iPhone_12_Pro_-_2022-09-20_at_23.19.56.png?table=block&id=a0567a67-2bb1-4577-b892-5fdd30f8dbe9&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=200> <img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Fbf619a33-8341-414b-96f5-7dc868e763b9%2FSimulator_Screen_Shot_-_iPhone_12_Pro_-_2022-09-20_at_23.21.29.png?table=block&id=575063b0-d2bd-4531-bb9c-473730752290&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=200> <img src="https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F4b8016ff-348d-4a1a-92e3-0b66deb551e9%2FSimulator_Screen_Shot_-_iPhone_12_Pro_-_2022-09-20_at_23.20.41.png?table=block&id=9b38d1af-c40c-4d16-96a9-c3e4145bfb1f&spaceId=e6b8a7b9-cbae-4355-941e-ce441f218386&width=2000&userId=aaeaa0fd-5da4-499b-9277-7adf273dceea&cache=v2" width=200> 
