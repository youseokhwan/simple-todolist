//
//  ThemeAlertController.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/28.
//

import UIKit

final class ThemeAlertController: UIAlertController {
    convenience init(children: [String], handler: @escaping (Int) -> Void) {
        self.init(title: Const.themeMenuTitle, message: nil, preferredStyle: .actionSheet)
        configure(children: children, handler: handler)
    }
}

private extension ThemeAlertController {
    func configure(children: [String], handler: @escaping (Int) -> Void) {
        children.enumerated()
            .map { index, value in
                UIAlertAction(title: value, style: .default) { _ in
                    handler(index)
                }
            }
            .forEach {
                addAction($0)
            }
        addAction(UIAlertAction(title: Const.cancel, style: .cancel))
    }
}
