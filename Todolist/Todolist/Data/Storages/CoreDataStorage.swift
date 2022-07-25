//
//  CoreDataStorage.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/27.
//

import CoreData
import Foundation

final class CoreDataStorage {
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Const.model)

        container.loadPersistentStores(completionHandler: { _, error in
            guard error == nil else {
                print("error: ", #file, #function, #line)

                return
            }
        })

        return container
    }()
    private lazy var viewContext = persistentContainer.viewContext

    func fetchAllTasks() -> [CDTask] {
        let fetchRequest = CDTask.fetchRequest()

        if let cdTasks = try? viewContext.fetch(fetchRequest) {
            return cdTasks
        } else {
            print("error: ", #file, #function, #line)

            return []
        }
    }

    func fetchTask(by id: String) -> CDTask? {
        let fetchRequest = CDTask.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "id LIKE %@", id)

        if let cdTasks = try? viewContext.fetch(fetchRequest) {
            return cdTasks.first
        } else {
            print("error: ", #file, #function, #line)

            return nil
        }
    }

    @discardableResult
    func create(task: Task) -> Bool {
        if let entity = NSEntityDescription.entity(forEntityName: Const.cdTask, in: viewContext) {
            let object = NSManagedObject(entity: entity, insertInto: viewContext)

            object.setValue(task.id, forKey: Const.id)
            object.setValue(task.context, forKey: Const.context)
            object.setValue(task.isDaily, forKey: Const.isDaily)
            object.setValue(task.isChecked, forKey: Const.isChecked)

            do {
                try viewContext.save()

                return true
            } catch {
                print("error: ", #file, #function, #line)

                return false
            }
        } else {
            print("error: ", #file, #function, #line)

            return false
        }
    }

    @discardableResult
    func update(task: Task) -> Bool {
        if let cdTask = fetchTask(by: task.id) {
            cdTask.setValue(task.context, forKey: Const.context)
            cdTask.setValue(task.isDaily, forKey: Const.isDaily)

            do {
                try viewContext.save()

                return true
            } catch {
                print("error: ", #file, #function, #line)

                return false
            }
        } else {
            print("error: ", #file, #function, #line)

            return false
        }
    }

    @discardableResult
    func delete(task: Task) -> Bool {
        if let cdTask = fetchTask(by: task.id) {
            viewContext.delete(cdTask)

            do {
                try viewContext.save()

                return true
            } catch {
                print("error: ", #file, #function, #line)

                return false
            }
        } else {
            print("error: ", #file, #function, #line)

            return false
        }
    }

    @discardableResult
    func deleteAllTasks() -> Bool {
        let cdTasks = fetchAllTasks()

        cdTasks.forEach {
            viewContext.delete($0)
        }

        do {
            try viewContext.save()

            return true
        } catch {
            print("error: ", #file, #function, #line)

            return false
        }
    }
}
