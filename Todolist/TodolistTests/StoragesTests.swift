//
//  StoragesTests.swift
//  TodolistTests
//
//  Created by 유석환 on 2022/09/28.
//

import XCTest

import RealmSwift

final class StoragesTests: XCTestCase {
    var realm: Realm!
    var dummyTasks: [Task]!
    var dummyOrderOfTasks: [TaskID]!

    override func setUpWithError() throws {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "StoragesTestsIdentifier"

        realm = try Realm()
        dummyTasks = [
            Task(id: 0, title: "Lorem ipsum", isDone: false, isDaily: false, createdDate: Date()),
            Task(id: 1, title: "dolor sit amet", isDone: false, isDaily: true, createdDate: Date()),
            Task(id: 2, title: "consectetur", isDone: true, isDaily: false, createdDate: Date()),
            Task(id: 3, title: "adipiscing elit", isDone: true, isDaily: true, createdDate: Date())
        ]
        dummyOrderOfTasks = [0, 1, 2, 3]

        try realm.write {
            dummyTasks.forEach { task in
                realm.add(task)
            }
            realm.create(OrderOfTasks.self)
            realm.objects(OrderOfTasks.self).first?.ids.append(objectsIn: dummyOrderOfTasks)
        }
    }

    override func tearDownWithError() throws {
        realm = nil
        dummyTasks = nil
        dummyOrderOfTasks = nil
    }

    func test_모든Task가져오기() throws {
        let tasks = RealmStorage.allTasks()

        XCTAssertEqual(tasks.count, dummyTasks.count)
        (0..<tasks.count).forEach { i in
            XCTAssertEqual(tasks[i].id, dummyTasks[i].id)
            XCTAssertEqual(tasks[i].title, dummyTasks[i].title)
        }
    }

    func test_Task생성() throws {
        let newTask = Task(id: 4,
                           title: "In vestibulum",
                           isDone: false,
                           isDaily: false,
                           createdDate: Date())

        RealmStorage.create(task: newTask)

        let tasks = realm.objects(Task.self)

        XCTAssertEqual(tasks.count, dummyTasks.count + 1)
        XCTAssertEqual(tasks.last!.id, newTask.id)
        XCTAssertEqual(tasks.last!.title, newTask.title)
    }

    func test_Task의Title수정() throws {
        let updatedTask = Task(id: 1,
                               title: "nunc nec sapien",
                               isDone: true,
                               isDaily: false,
                               createdDate: Date())

        RealmStorage.update(task: updatedTask)

        let task = realm.object(ofType: Task.self, forPrimaryKey: 1)!

        XCTAssertEqual(task.id, updatedTask.id)
        XCTAssertEqual(task.title, updatedTask.title)
        XCTAssertNotEqual(task.title, "dolor sit amet")
    }

    func test_Task삭제() throws {
        RealmStorage.delete(task: dummyTasks[1])

        let tasks = realm.objects(Task.self)
        let taskWithDeletedID = realm.object(ofType: Task.self, forPrimaryKey: 1)

        XCTAssertEqual(tasks.count, dummyTasks.count - 1)
        XCTAssertNil(taskWithDeletedID)
    }

    func test_OrderOfTasks가져오기() throws {
        let orderOfTasks = RealmStorage.orderOfTasks()

        XCTAssertEqual(orderOfTasks, dummyOrderOfTasks)
    }

    func test_Task이동() throws {
        RealmStorage.moveTask(at: 0, to: 2)

        let tasks = RealmStorage.allTasks()
        let orderOfTasks = RealmStorage.orderOfTasks()

        (0..<tasks.count).forEach { i in
            XCTAssertEqual(tasks[i].id, dummyTasks[i].id)
            XCTAssertEqual(tasks[i].title, dummyTasks[i].title)
        }
        XCTAssertEqual(orderOfTasks, [1, 2, 0, 3])
    }
}
