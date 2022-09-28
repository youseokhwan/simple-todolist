//
//  StoragesTests.swift
//  TodolistTests
//
//  Created by 유석환 on 2022/09/28.
//

import XCTest
import RealmSwift

final class StoragesTests: XCTestCase {
    override func setUpWithError() throws {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "StoragesTestsIdentifier"
    }

    override func tearDownWithError() throws {

    }

    func testExample() throws {
        
    }
}
