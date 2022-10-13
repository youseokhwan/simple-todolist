//
//  UIFont+Extensions.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/10/13.
//

import UIKit

extension UIFont {
    convenience init?(_ name: FontName, size: CGFloat) {
        self.init(name: name.rawValue, size: size)
    }
}
