//
//  UIFont+Extensions.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/10/13.
//

import UIKit

extension UIFont {
    static func instance(_ name: FontName, size: CGFloat) -> UIFont {
        let font = UIFont(name: name.rawValue, size: size)

        return font ?? systemFont(ofSize: size)
    }
}
