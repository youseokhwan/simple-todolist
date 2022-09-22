//
//  UILabel+Extensions.swift
//  Todolist
//
//  Created by 유석환 on 2022/08/03.
//

import UIKit

extension UILabel {
    func strikethrough(isActive: Bool, withText: String) {
        guard let foregroundColor = UIColor(.commonText50) else { return }

        let attributedString = NSMutableAttributedString(string: withText)

        if isActive {
            attributedString.addAttribute(.strikethroughStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSMakeRange(0, attributedString.length))
            attributedString.addAttribute(.foregroundColor,
                                          value: foregroundColor,
                                          range: NSMakeRange(0, attributedString.length))
        } else {
            attributedString.removeAttribute(.strikethroughStyle,
                                             range: NSMakeRange(0, attributedString.length))
            attributedString.removeAttribute(.foregroundColor,
                                             range: NSMakeRange(0, attributedString.length))
        }
        
        attributedText = attributedString
    }
}
