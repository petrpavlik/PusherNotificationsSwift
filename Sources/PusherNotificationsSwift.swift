import Foundation

public enum PusherError: Error {
    case invalidInput
    case invalidResponse
    case invalidResponseStatusCode(statusCode: Int)
}

public class Pusher {
    
    private let appId: String
    private let appKey: String
    private let appSecret: String
    
    public init(appKey: String, appSecret: String, appId: String) {
        self.appId = appId
        self.appKey = appKey
        self.appSecret = appSecret
    }
    
    public func notify(interests: [String], apns: [String:Any]? = nil, gcm: [String:Any]? = nil, fcm: [String:Any]? = nil, webhookURL: URL? = nil, webhookLevel: String = "INFO", completion: @escaping (_ error: Error?) -> Void) {
    
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
            bodyDictionary["webhook_url"] = webhookURL
            bodyDictionary["webhook_level"] = webhookLevel
        }
        
        bodyDictionary["auth_key"] = appKey
        bodyDictionary["auth_timestamp"] = round(Date().timeIntervalSince1970)
        bodyDictionary["auth_version"] = 1.0
        
        do {
            
            let bodyData = try JSONSerialization.data(withJSONObject: bodyDictionary, options: [])
            
            let session = URLSession.shared
            let request = NSMutableURLRequest(url: URL(string: "/v1/apps/\(appId)/notifications")!)
            request.httpMethod = "POST"
            request.httpBody = bodyData
            
            bodyDictionary["body_md5"] = String(data: bodyData, encoding: .utf8)!.md5
            
            session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                if let error = error {
                    completion(error)
                } else if let response = response as? HTTPURLResponse {
                    if 200 ... 299 ~= response.statusCode {
                        completion(nil)
                    } else {
                        completion(PusherError.invalidResponseStatusCode(statusCode: response.statusCode))
                    }
                } else {
                    completion(PusherError.invalidResponse)
                }
            })
            
        } catch {
            completion(PusherError.invalidInput)
        }
        
        
    }
    
}
