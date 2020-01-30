import XCTest
@testable import ipspatcher

final class ipspatcherTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ipspatcher().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
