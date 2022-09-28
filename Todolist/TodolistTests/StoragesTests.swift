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

    override func setUpWithError() throws {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "StoragesTestsIdentifier"

        let dummyTasks = [
            Task(id: 0, title: "Lorem ipsum", isDone: false, isDaily: false, createdDate: Date()),
            Task(id: 1, title: "dolor sit amet", isDone: false, isDaily: true, createdDate: Date()),
            Task(id: 2, title: "consectetur", isDone: true, isDaily: false, createdDate: Date()),
            Task(id: 3, title: "adipiscing elit", isDone: true, isDaily: true, createdDate: Date())
        ]

        realm = try Realm()
        try realm.write {
            dummyTasks.forEach { task in
                realm.add(task)
            }
        }
    }

    override func tearDownWithError() throws {
        realm = nil
    }

    func testExample() throws {
        let testArr = realm.objects(Task.self)
        XCTAssertEqual(testArr.count, 4)
    }
}
