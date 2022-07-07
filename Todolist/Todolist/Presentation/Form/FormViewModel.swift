//
//  FormViewModel.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import Foundation

import RxSwift

final class FormViewModel {
    var context = ""
    var isDaily = false

    func addTask() {
        // dummy logic
        print("context: \(context), isDaily: \(isDaily)")
    }
}
