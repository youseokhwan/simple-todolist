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

    override func setUpWithError() throws {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "StoragesTestsIdentifier"

        realm = try Realm()
        dummyTasks = [
            Task(id: 0, title: "Lorem ipsum", isDone: false, isDaily: false, createdDate: Date()),
            Task(id: 1, title: "dolor sit amet", isDone: false, isDaily: true, createdDate: Date()),
            Task(id: 2, title: "consectetur", isDone: true, isDaily: false, createdDate: Date()),
            Task(id: 3, title: "adipiscing elit", isDone: true, isDaily: true, createdDate: Date())
        ]

        try realm.write {
            dummyTasks.forEach { task in
                realm.add(task)
            }
        }
    }

    override func tearDownWithError() throws {
        realm = nil
        dummyTasks = nil
    }

    func test_모든Task가져오기() throws {
        let tasks = RealmStorage.taskResults()!

        XCTAssertEqual(tasks.count, dummyTasks.count)
        (0..<tasks.count).forEach { i in
            XCTAssertEqual(tasks[i], dummyTasks[i])
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
        XCTAssertEqual(tasks.last!, newTask)
    }

    func test_Task의Title수정() throws {
        let updatedTask = Task(id: 1,
                               title: "nunc nec sapien",
                               isDone: true,
                               isDaily: false,
                               createdDate: Date())

        RealmStorage.update(task: updatedTask)

        let task = realm.object(ofType: Task.self, forPrimaryKey: 1)

        XCTAssertEqual(task, updatedTask)
    }

    func test_Task의isDone수정() throws {
        RealmStorage.updateIsDone(of: dummyTasks[1], value: true)
        RealmStorage.updateIsDone(of: dummyTasks[2], value: false)

        let tasks = realm.objects(Task.self)

        XCTAssertEqual(tasks[1].isDone, true)
        XCTAssertEqual(tasks[2].isDone, false)
    }

    func test_Task삭제() throws {
        RealmStorage.delete(task: dummyTasks[1])

        let tasks = realm.objects(Task.self)
        let taskWithDeletedID = realm.object(ofType: Task.self, forPrimaryKey: 1)

        XCTAssertEqual(tasks.count, dummyTasks.count - 1)
        XCTAssertNil(taskWithDeletedID)
    }
}
