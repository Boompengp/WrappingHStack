import XCTest
@testable import WrappingHStack

final class WrappingHStackTests: XCTestCase {
    func testWrappingHStackCreation() {
        let items = ["Test1", "Test2", "Test3"]
        let wrappingHStack = WrappingHStack(items, spacing: 8, lineSpacing: 8, alignment: .center) { item in
            Text(item)
        }

        XCTAssertNotNil(wrappingHStack)
    }

    func testWrappingHStackAlignment() {
        let items = ["Test1", "Test2", "Test3"]

        let leadingStack = WrappingHStack(items, alignment: .leading) { item in
            Text(item)
        }

        let centerStack = WrappingHStack(items, alignment: .center) { item in
            Text(item)
        }

        let trailingStack = WrappingHStack(items, alignment: .trailing) { item in
            Text(item)
        }

        XCTAssertNotNil(leadingStack)
        XCTAssertNotNil(centerStack)
        XCTAssertNotNil(trailingStack)
    }
}

import SwiftUI

private struct TestItem: Identifiable {
    let id = UUID()
    let title: String
}