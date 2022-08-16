//
//  SettingsNavigationController.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/08/16.
//

import UIKit

final class SettingsNavigationController: UINavigationController {
    convenience init() {
        let controller = SettingsViewController()
        
        self.init(rootViewController: controller)
    }
}
