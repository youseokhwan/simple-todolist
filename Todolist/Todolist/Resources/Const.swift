//
//  Const.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/20.
//

import Foundation

enum Const {
    // Tasks
    static let tasksTableViewCellID = "TasksTableViewCell"
    static let formButtonImage = "plus"
    static let settingsButtonImage = "gearshape.fill"
    static let checkButtonNormalImage = "circle"
    static let checkButtonSelectedImage = "checkmark.circle.fill"

    // Form
    static let addButtonImage = "checkmark"
    static let contextTextFieldMaxCount = 20
    static let contextTextFieldPlaceholder = "contextTextFieldPlaceholder".localized
    static let dailyLabelText = "dailyLabelText".localized

    // Settings
    static let settingsTableViewCellID = "SettingsTableViewCell"
    static let settingsTitle = "settingsTitle".localized
    static let appSettingsSection = "appSettingsSection".localized
    static let themeSettings = "themeSettings".localized
    static let informationSection = "informationSection".localized
    static let openSourceLicense = "openSourceLicense".localized
    static let versionInfomation = "versionInfomation".localized
    static let patchDetails = "patchDetails".localized
    static let contactUs = "contactUs".localized

    // Settings - Theme
    static let themeTableViewCellID = "ThemeTableViewCell"
    static let themeMenuTitle = "themeMenuTitle".localized
    static let systemTheme = "systemTheme".localized
    static let lightTheme = "lightTheme".localized
    static let darkTheme = "darkTheme".localized

    // Repositories
    static let nextTaskID = "nextTaskID"

    // Storages
    static let model = "Model"
    static let cdTask = "CDTask"
    static let id = "id"
    static let context = "context"
    static let isDaily = "isDaily"
    static let isChecked = "isChecked"

    // Utils
    static let localizable = "Localizable"
    static let yyyyMMdd = "yyyy.MM.dd"
}
