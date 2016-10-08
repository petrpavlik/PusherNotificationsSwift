import Foundation
import XCTest

@testable import PusherNotificationsSwift
@testable import Hash
@testable import HMAC

class PusherNotificationsSwiftTests: XCTestCase {
    
    func testHashing() {
        
        let bodyDictionary: [String:Any] = [
            "interests": ["unittests"],
            "apns": ["aps": ["alert": ["body": "hello world"]]]
        ]
        
        let bodyData = try! JSONSerialization.data(withJSONObject: bodyDictionary, options: [])
        let bodyMd5String = try! Hash.make(.md5, try bodyData.makeBytes()).hexString
        
        XCTAssertEqual(bodyMd5String, "6cc9f15745c9079a143b14eea74ccc98")
    }
    
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
            ("testHashing", testHashing)
        ]
    }
}
