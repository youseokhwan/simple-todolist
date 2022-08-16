//
//  ReadBundleResourceUseCase.swift
//  Todolist
//
//  Created by 유석환 on 2022/08/16.
//

import Foundation

struct ReadBundleResourceUseCase {
    enum LicenseFileName: String, CaseIterable {
        case realmSwift = "realm-swift"
        case rxDataSources = "RxDataSources"
        case rxRealm = "RxRealm"
        case rxSwift = "RxSwift"
        case snapKit = "SnapKit"
    }

    func licensesText() -> String {
        let text = LicenseFileName.allCases.map { $0.rawValue }.joined(separator: "\n=====\n")

        return text
    }
}
