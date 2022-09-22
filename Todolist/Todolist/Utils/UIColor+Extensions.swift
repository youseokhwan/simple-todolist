//
//  UIColor+Extensions.swift
//  Todolist
//
//  Created by 유석환 on 2022/09/22.
//

import UIKit

extension UIColor {
    convenience init?(_ colorSet: ColorSet) {
        self.init(named: colorSet.rawValue)
    }
}
