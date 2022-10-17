//
//  UIFont+Extensions.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/10/13.
//

import UIKit

extension UIFont {
    static func unwrappedFont(_ name: FontName, size: CGFloat) -> UIFont {
        let customFont = UIFont(name: name.rawValue, size: size)
        let systemFontMedium = self.systemFont(ofSize: size, weight: .medium)
        let systemFontBold = self.systemFont(ofSize: size, weight: .bold)

        return customFont ?? (name == .theCircleM ? systemFontMedium : systemFontBold)
    }
}
