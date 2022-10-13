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

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension SettingsNavigationController {
    func configure() {
        navigationBar.prefersLargeTitles = true

        if let font = UIFont(.theCircleB, size: 36) {
            navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: font]
        }
    }
}
