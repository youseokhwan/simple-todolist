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
        let font = UIFont.instance(.theCircleB, size: 34)

        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: font]
    }
}
