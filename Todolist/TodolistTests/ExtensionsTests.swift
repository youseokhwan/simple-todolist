//
//  ExtensionsTests.swift
//  TodolistTests
//
//  Created by 유석환 on 2022/09/22.
//

import XCTest
@testable import Todolist

final class StringTests: XCTestCase {
    var text: String!

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        text = nil
    }

    func test_앞뒤공백이없는경우() throws {
        text = "Test"
        XCTAssertEqual(text.trimmed, "Test")
    }

    func test_앞에공백이있는경우() throws {
        text = " \nTest"
        XCTAssertEqual(text.trimmed, "Test")
    }

    func test_뒤에공백이있는경우() throws {
        text = "Test \n"
        XCTAssertEqual(text.trimmed, "Test")
    }

    func test_앞뒤공백이있는경우() throws {
        text = " \nTest \n"
        XCTAssertEqual(text.trimmed, "Test")
    }

    func test_중간에공백이있는경우() throws {
        text = "Te \nst"
        XCTAssertEqual(text.trimmed, "Te \nst")
    }

    func test_앞뒤중간모두공백이있는경우() throws {
        text = " \nTe \nst \n"
        XCTAssertEqual(text.trimmed, "Te \nst")
    }
}

final class DateTests: XCTestCase {
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testExample() throws {

    }
}

final class UILabelTests: XCTestCase {
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testExample() throws {

    }
}

final class UIImageTests: XCTestCase {
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testExample() throws {

    }
}
