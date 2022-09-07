//
//  Const.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/20.
//

import Foundation

enum Const {
    // Tasks
    static let formButtonImage = "plus"
    static let settingsButtonImage = "user"
    static let checkButtonNormalImage = "circle"
    static let checkButtonSelectedImage = "checked"
    static let editButtonImage = "edit"
    static let deleteButtonImage = "delete"
    static let formButtonTitle = "addTask".localized

    // Form
    static let formTitleCreateLabelText = "formTitleCreateLabel".localized
    static let formTitleUpdateLabelText = "formTitleUpdateLabel".localized
    static let tempIDForNewTask = -1
    static let saveButtonImage = "done"
    static let titleTextViewMaxCount = 100
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

    // UseCases
    static let txt = "txt"
    static let licenseSeparator = "\n\n=====\n\n"

    // Repositories
    static let nextTaskID = "nextTaskID"
    static let lastFetchDate = "lastFetchDate"
    static let minDate = "1900.01.01"
    static let appearance = "Appearance"

    // Storages
    static let id = "id"
    static let title = "title"
    static let isDaily = "isDaily"
    static let isDone = "isDone"

    // Utils
    static let localizable = "Localizable"
}
