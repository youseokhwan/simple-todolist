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
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = TasksViewController()
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = UIUserInterfaceStyle(
            rawValue: UserDefaultsRepository.currentAppearance()
        ) ?? .unspecified
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        NotificationCenter.default.post(name: Self.sceneWillEnterForeground,
                                        object: nil,
                                        userInfo: nil)
    }
}
