# LiVRE

<p align="center"><img src="./image/ver-2/LiVRE_logo_text.png" width="400" /></p>

**책을 검색하고 즐겨찾는, 책 검색 서비스 LiVRE**

**LiVRE(리브)** 는 검색하고 싶은 책을 찾고, 판매사이트(인터파크 도서)로 바로 넘어갈 수 있습니다. 또한, 지금은 읽고싶지 않거나 읽을 시간이 없지만 나중에는 꼭 읽어봐야지 하는 책이 있다면 **즐겨찾기** 기능을 이용해보세요. **즐겨찾기** 기능을 통해 원하는 책을 체크해둘 수 있습니다.

 

책을 검색할 때마다 **포인트**를 얻을 수 있습니다. 얻은 포인트에 따라 **레벨**이 정해지고, **레벨**에 따라 **HOME 화면**에 보여지는 리워드 애니메이션이 달라집니다 :)

 

<p align="center"><img width="300" alt="리워드" src="https://user-images.githubusercontent.com/22339322/113500548-d5692d80-9559-11eb-8239-13f013dc8d28.png"></p>

 


 

혹시 **책에 대한 후기**가 궁금하다면, 검색화면 하단에 있는 블로그 필드에서 책 후기를 보실 수 있습니다. 검색창에 책의 제목을 좀 더 정확하게 검색할 수록 블로그 후기도 좀 더 정확해져요!

<br />

🚫 프로젝트를 실행하기 위해서는 네이버API와 키워드API key 정보가 담긴 SecretKeySet.swift 파일이 따로 필요합니다!! 만약 실행을 원한다면, 저에게 SecretKeySet.swift 파일을 요청하시거나 [네이버 검색 Open API](https://developers.naver.com/docs/search/blog/)의 Key와 [AI Cloud Open API](https://www.saltlux.ai/)의 Key를 얻어서 아래와 같은 파일을 `Livre/livre/Data/Network/ 파일 안`에 생성해서 실행하면 됩니다.
```swift
struct SecretKeySet {
    static let keywordKey = "AI Cloud Open API key"
    static let keywordServiceId = "AI Cloud Open API service id"
    
    static let naverClientId = "네이버 검색 Open API client id"
    static let naverClientSecret = "네이버 검색 Open API client secret"
}
```

<br />

* 기획 및 디자인: 2021.01
<!-- * 기획 및 디자인 : 1/14 ~ 1/17 -->
* 개발 기간
    + ver 2.0: 2021.03 ~ 2021.04
    + ver 1.0: 2021.01
    <!-- + ver 2.0: 3/22 ~ 4/4
    + ver 1.0: 1/17 ~ 1/29 -->
* ver 2.0 - 피드백 및 사용자 리뷰 : [이슈 #38](https://github.com/kimhyebeen/ios-livre/issues/38)
* ver 1.0 - 피드백 및 사용자 리뷰 : [이슈 #30](https://github.com/kimhyebeen/ios-livre/issues/30)

<br />

## Technology Stack
`Swift`, `MVVM`

 

`Almofire`, `RxSwift/RxCocoa`, `CoreData`, `SnapKit`, `Lottie`

 

`Zeplin`, `Figma`

<br />

## ScreenShot - ver 2.0
<img src="./image/ver-2/screenshot.png" width="900" />

<details>
<summary>ScreenShot - ver 1.0 (클릭하면 펼쳐집니다)</summary>
<div markdown="1">

<img src="./image/ver-1/main-screenshot.png" width="900" />

</div>
</details>

<br />

## Reference
* 책 검색 API : [네이버 검색 Open API](https://developers.naver.com/docs/search/book/)
* 블로그 검색 API : [네이버 검색 Open API](https://developers.naver.com/docs/search/blog/)
* 키워드 분석 API : [AI Cloud Open API](https://www.saltlux.ai/)
