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
        case rxSwift = "RxSwift"
        case snapKit = "SnapKit"
        case theCircle = "TheCircle"
    }

    func licensesText() -> String {
        let text = LicenseFileName.allCases.map {
            guard let fileURL = Bundle.main.url(forResource: $0.rawValue, withExtension: "txt"),
                  let contents = try? String(contentsOf: fileURL) else { return "" }

            return "[\($0.rawValue)]\n\n\(contents)"
        }.joined(separator: "\n\n=====\n\n")

        return text
    }

    func appVersionText() -> String {
        guard let object = Bundle.main.infoDictionary?["CFBundleShortVersionString"],
              let appVersion = object as? String else { return "" }

        return "v\(appVersion)"
    }
}
