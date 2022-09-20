//
//  Constants.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/20.
//

enum ButtonImage: String {
    case settings
    case doneNormal
    case doneSelected
    case delete
}

enum ButtonTitle: String {
    case addButton = "할 일 추가"
    case saveButton = "완료"
}

enum ColorSet: String {
    case background
    case buttonTitle
    case subBackground
    case text
}

enum LabelText: String {
    case formTitleAtCreation = "할 일 추가"
    case formTitleAtModification = "할 일 수정"
    case formTextViewPlaceholder = "할 일을 입력하세요"
    case isDone = "완료 여부"
    case isDaily = "매일 반복"
    case createdDate = "생성일"
    case settings = "설정"
}

enum SettingsText: String {
    case appSettingsSection = "앱 설정"
    case themeItem = "테마 설정"
    case themeMenuTitle = "테마를 선택해주세요"
    case systemThemeItem = "디바이스 설정에 따름"
    case lightThemeItem = "라이트모드 적용"
    case darkThemeItem = "다크모드 적용"
    case cancelItem = "취소"
    case informationSection = "앱 정보"
    case licenseItem = "오픈소스 라이선스"
    case versionItem = "버전 정보"
    case contactUsItem = "Contact Us"
    case emailURL = "mailto:youseokhwan15@gmail.com,folw159@gmail.com"
}

enum UserDefaultsKey: String {
    case nextTaskID
    case lastFetchDate
    case appearance
}
