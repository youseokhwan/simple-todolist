//
//  UILabel+Extensions.swift
//  Todolist
//
//  Created by 유석환 on 2022/08/03.
//

import UIKit

extension UILabel {
    func strikethrough(context: String?, isActive: Bool) {
        guard let context = context else { return }

        let attributedString = NSMutableAttributedString(string: context)

        if isActive {
            attributedString.addAttribute(.strikethroughStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSMakeRange(0, attributedString.length))
            attributedString.addAttribute(.foregroundColor,
                                          value: UIColor.systemGray,
                                          range: NSMakeRange(0, attributedString.length))

            attributedText = attributedString
        } else {
            attributedString.removeAttribute(.strikethroughStyle,
                                             range: NSMakeRange(0, attributedString.length))
            attributedString.removeAttribute(.foregroundColor,
                                             range: NSMakeRange(0, attributedString.length))

            attributedText = attributedString
        }
    }
}
