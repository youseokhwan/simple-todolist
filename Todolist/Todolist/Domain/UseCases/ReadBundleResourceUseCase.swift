//
//  ReadBundleResourceUseCase.swift
//  Todolist
//
//  Created by 유석환 on 2022/08/16.
//

import Foundation

struct ReadBundleResourceUseCase {
    enum LicenseFileName: String, CaseIterable, Comparable {
        case realmSwift = "realm-swift"
        case rxDataSources = "RxDataSources"
        case rxRealm = "RxRealm"
        case rxSwift = "RxSwift"
        case snapKit = "SnapKit"

        static func < (lhs: Self, rhs: Self) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
    }

    func licensesText() -> String {
        let text = LicenseFileName.allCases.sorted().map {
            guard let fileURL = Bundle.main.url(forResource: $0.rawValue, withExtension: "txt"),
                  let contents = try? String(contentsOf: fileURL) else { return "" }

            return "[\($0.rawValue)]\n\n\(contents)"
        }.joined(separator: "\n\n=====\n\n")

        return text
    }
}
