import Foundation

// Vapor frameworks
import Vapor
import Crypto
import HTTP

public enum PusherError: Error {
    case invalidInput
    case invalidResponse
    case invalidResponseStatusCode(statusCode: Int, description: String?)
}

final public class Pusher {
    
    private let appId: String
    private let appKey: String
    private let appSecret: String
    
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    public init(appKey: String, appSecret: String, appId: String) {
        self.appId = appId
        self.appKey = appKey
        self.appSecret = appSecret
    }
    
    public func notify(interests: [String], apns: [String:Any]? = nil, gcm: [String:Any]? = nil, fcm: [String:Any]? = nil, webhookURL: URL? = nil, webhookLevel: String = "INFO") throws {
    
        var bodyDictionary: [String:Any] = [
            "interests": interests
        ]
        
        if let apns = apns {
            bodyDictionary["apns"] = apns
        }

        if let gcm = gcm {
            bodyDictionary["gcm"] = gcm
        }

        if let fcm = fcm {
            bodyDictionary["fcm"] = fcm
        }

        if let webhookURL = webhookURL {
            bodyDictionary["webhook_url"] = webhookURL.absoluteString
            bodyDictionary["webhook_level"] = webhookLevel
        }
        
        let bodyData = try JSONSerialization.data(withJSONObject: bodyDictionary, options: [])
        let bodyMd5String = try Hash.make(.md5, bodyData.makeBytes()).hexString
        let queries = "auth_key=\(appKey)&auth_timestamp=\(Int64(Date().timeIntervalSince1970))&auth_version=1.0&body_md5=\(bodyMd5String)"
        let authSignature = try HMAC.make(.sha256, "POST\n/server_api/v1/apps/\(appId)/notifications\n\(queries)".bytes, key: appSecret.bytes).hexString
        
        let body = Body.data(bodyData.makeBytes())
        _ = try EngineClient.factory.post("https://nativepush-cluster1.pusher.com/server_api/v1/apps/\(appId)/notifications?\(queries)&auth_signature=\(authSignature)", query: [:], [HeaderKey("Content-Type"): "application/json"], body, through: [])
    }
    
}
