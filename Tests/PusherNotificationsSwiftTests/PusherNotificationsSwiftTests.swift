import XCTest
@testable import PusherNotificationsSwift

class PusherNotificationsSwiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(PusherNotificationsSwift().text, "Hello, World!")
    }


    static var allTests : [(String, (PusherNotificationsSwiftTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
