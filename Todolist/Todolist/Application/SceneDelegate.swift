//
//  SceneDelegate.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/19.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    static let sceneWillEnterForeground = Notification.Name("sceneWillEnterForeground")

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        configure(scene: scene)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        NotificationCenter.default.post(name: Self.sceneWillEnterForeground,
                                        object: nil,
                                        userInfo: nil)
    }
}

private extension SceneDelegate {
    func configure(scene: UIScene) {
        configureWindow(scene: scene)
        configureFonts()
    }

    func configureWindow(scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = TasksViewController()
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = UIUserInterfaceStyle(
            rawValue: UserDefaultsRepository.currentAppearance()
        ) ?? .unspecified
    }

    func configureFonts() {
        let defaultFont = UIFont.unwrappedFont(.theCircleM, size: 18)

        UILabel.appearance().font = defaultFont
        UITextView.appearance().font = defaultFont
    }
}
