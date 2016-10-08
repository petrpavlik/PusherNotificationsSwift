import Foundation
import XCTest

@testable import PusherNotificationsSwift

class PusherNotificationsSwiftTests: XCTestCase {
    
    func testExample() {
        
        let pusher = Pusher(appKey: "eb06ab72c5538445fdfc", appSecret: "2b4f128d1ad1656699a5", appId: "257217")
        do {
            try pusher.notify(interests: ["unittests"], apns: ["aps": ["alert": ["body": "hello world"]]])
        } catch {
            XCTFail()
        }
    }


    static var allTests : [(String, (PusherNotificationsSwiftTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample)
        ]
    }
}
