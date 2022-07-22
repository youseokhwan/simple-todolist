//
//  UIViewContoller+Extensions.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/22.
//

import UIKit

extension UIViewController {
    func checkAppearance(_ viewContoller: UIViewController) {
        switch UserDefaults.standard.integer(forKey: "Appearance") {
        case 0:
            overrideUserInterfaceStyle = .unspecified
        case 1:
            overrideUserInterfaceStyle = .light
        case 2:
            overrideUserInterfaceStyle = .dark
        default:
            overrideUserInterfaceStyle = .unspecified
        }
    }
}
