//
//  ThemeAlertController.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/28.
//

import UIKit

final class ThemeAlertController: UIAlertController {
    convenience init(children: [String]) {
        self.init(title: Const.themeMenuTitle, message: nil, preferredStyle: .actionSheet)
        configure(children: children)
    }
}

private extension ThemeAlertController {
    func configure(children: [String]) {
        children.enumerated()
            .map { index, value in
                UIAlertAction(title: value, style: .default, handler: nil)
            }
            .forEach {
                addAction($0)
            }
        addAction(UIAlertAction(title: Const.cancel, style: .cancel))
    }
}
