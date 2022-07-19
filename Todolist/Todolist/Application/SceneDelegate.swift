//
//  SceneDelegate.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/19.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let tasksViewController = TasksViewController()
        let navigationContoller = UINavigationController(rootViewController: tasksViewController)

        window?.rootViewController = navigationContoller
        window?.makeKeyAndVisible()
    }
}
