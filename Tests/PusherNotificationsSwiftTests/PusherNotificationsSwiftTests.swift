import XCTest
@testable import PusherNotificationsSwift

class PusherNotificationsSwiftTests: XCTestCase {
    
    func testExample() {
        
        let notificationSentExpectation = self.expectation(description: "send notification request")
        
        let pusher = Pusher(appKey: "eb06ab72c5538445fdfc", appSecret: "2b4f128d1ad1656699a5", appId: "257217")
        pusher.notify(interests: ["unittests"], apns: ["aps": ["alert": ["body": "hello world"]]]) { (error) in
            
            XCTAssertNil(error)
            notificationSentExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }


    static var allTests : [(String, (PusherNotificationsSwiftTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
