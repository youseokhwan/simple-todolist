//
//  String+Extensions.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/20.
//

import Foundation

extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
