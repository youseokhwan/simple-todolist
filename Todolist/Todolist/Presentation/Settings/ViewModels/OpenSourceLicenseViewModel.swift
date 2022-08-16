//
//  OpenSourceLicenseViewModel.swift
//  Todolist
//
//  Created by 유석환 on 2022/08/16.
//

import Foundation

final class OpenSourceLicenseViewModel {
    private let readBundleResourceUseCase: ReadBundleResourceUseCase

    init() {
        readBundleResourceUseCase = ReadBundleResourceUseCase()
    }

    func openSourceLicenseText() -> String {
        return readBundleResourceUseCase.licensesText()
    }
}