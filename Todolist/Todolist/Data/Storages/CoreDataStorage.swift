//
//  CoreDataStorage.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/27.
//

import CoreData
import Foundation

final class CoreDataStorage {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { _, error in
            guard error == nil else {
                print(#file, #line, "loadPersistentStores error")
                return
            }
        })
        return container
    }()
    lazy var viewContext = persistentContainer.viewContext

    func fetchAllTasks() -> [CDTask] {
        let fetchRequest = CDTask.fetchRequest()

        if let cdTasks = try? viewContext.fetch(fetchRequest) {
            return cdTasks
        } else {
            print(#file, #line, "fetch fail")
            return []
        }
    }
}
