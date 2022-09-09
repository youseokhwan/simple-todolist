//
//  Constants.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/20.
//

enum ButtonImage {
    static let add = "plus"
    static let settings = "user"
    static let doneNormal = "circle"
    static let doneSelected = "checked"
    static let edit = "edit"
    static let delete = "delete"
    static let save = "done"
}

enum UserDefaultsKey {
    static let nextTaskID = "nextTaskID"
    static let lastFetchDate = "lastFetchDate"
    static let appearance = "appearance"
}

enum Const {
    // Tasks
    static let formButtonTitle = "addTask".localized

    // Form
    static let formTitleCreateLabelText = "formTitleCreateLabel".localized
    static let formTitleUpdateLabelText = "formTitleUpdateLabel".localized
    static let titleTextViewPlaceholder = "titleTextViewPlaceholder".localized
    static let doneLabelText = "doneLabelText".localized
    static let dailyLabelText = "dailyLabelText".localized
    static let createdDateLabelText = "createdDateLabelText".localized
    static let saveButtonTitle = "saveButtonTitle".localized

    // Settings
    static let settingsTitle = "settingsTitle".localized
    static let appSettingsSection = "appSettingsSection".localized
    static let themeSettings = "themeSettings".localized
    static let informationSection = "informationSection".localized
    static let openSourceLicense = "openSourceLicense".localized
    static let versionInfomation = "versionInfomation".localized
    static let patchDetails = "patchDetails".localized
    static let contactUs = "contactUs".localized
    static let themeMenuTitle = "themeMenuTitle".localized
    static let systemTheme = "systemTheme".localized
    static let lightTheme = "lightTheme".localized
    static let darkTheme = "darkTheme".localized
    static let cancel = "cancel".localized
    static let emailURL = "mailto:youseokhwan15@gmail.com,folw159@gmail.com"
}
