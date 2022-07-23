//
//  UIViewContoller+Extensions.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/22.
//

import UIKit

extension UIViewController {
    func checkAppearance() {
        [UIUserInterfaceStyle.unspecified, UIUserInterfaceStyle.light, UIUserInterfaceStyle.dark]
            .enumerated()
            .filter { index, value in
                index == UserDefaultsRepository.currentAppearance()
            }
            .forEach { index, value in
                overrideUserInterfaceStyle = value
            }
    }
}
