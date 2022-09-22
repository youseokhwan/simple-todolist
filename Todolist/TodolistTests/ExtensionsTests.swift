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

final class UILabelTests: XCTestCase {
    var text: String!
    var label: UILabel!

    override func setUpWithError() throws {
        text = "Hello World!"
        label = UILabel()
    }

    override func tearDownWithError() throws {
        text = nil
        label = nil
    }

    func test_취소선적용() throws {
        label.strikethrough(isActive: true, withText: text)

        if let attributedText = label.attributedText,
           let strikethroughAttribute = attributedText.attributes(at: 0, effectiveRange: nil)
            .first(where: { $0.key == .strikethroughStyle }),
           let strikethroughValue = strikethroughAttribute.value as? Int,
           let foregroundColorAttribute = attributedText.attributes(at: 0, effectiveRange: nil)
            .first(where: { $0.key == .foregroundColor }),
           let foregroundColorValue = foregroundColorAttribute.value as? UIColor,
           let expectedColor = UIColor(named: ColorSet.commonText50.rawValue) {
            XCTAssertEqual(attributedText.string, text)
            XCTAssertEqual(strikethroughValue, NSUnderlineStyle.single.rawValue)
            XCTAssertEqual(foregroundColorValue, expectedColor)
        } else {
            XCTFail("XCTFail: variable is nil")
        }
    }

    func test_취소선해제() throws {
        label.strikethrough(isActive: false, withText: text)

        if let attributedText = label.attributedText {
            let strikethroughAttribute = attributedText.attributes(at: 0, effectiveRange: nil)
                .first(where: { $0.key == .strikethroughStyle })
            let foregroundColorAttribute = attributedText.attributes(at: 0, effectiveRange: nil)
                .first(where: { $0.key == .foregroundColor })

            XCTAssertEqual(attributedText.string, text)
            XCTAssertNil(strikethroughAttribute)
            XCTAssertNil(foregroundColorAttribute)
        } else {
            XCTFail("XCTFail: variable is nil")
        }
    }
}

final class UIImageTests: XCTestCase {
    var image: UIImage!
    var size: CGSize!

    override func setUpWithError() throws {
        image = UIImage(systemName: "applelogo")
        size = CGSize(width: 30, height: 30)
    }

    override func tearDownWithError() throws {
        image = nil
    }

    func test_resizedImage사이즈확인() throws {
        let resizedImage = image.resizedImage(size: size)

        XCTAssertEqual(resizedImage.size.width, size.width)
        XCTAssertEqual(resizedImage.size.height, size.height)
    }
}
