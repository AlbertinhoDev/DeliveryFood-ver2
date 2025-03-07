import Foundation
import Core

extension Profile {
    enum Endpoint {
        case getUser
    }
}




extension Profile.Endpoint: Endpoint {
    var scheme: HTTPScheme {
        switch self {
        case .getUser:
            return .https
        }
    }
    
    var host: String {
        switch self {
        case .getUser:
            return "dummyjson.com"
        }
    }
    
    var path: String {
        switch self {
        case .getUser:
            return "/auth/me"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUser:
            return .get
        }
    }
    
    var headers: [String : String] {
        var headers: [String : String] = [:]
        
        switch self {
        case .getUser:
            break
        }
        return headers
    }
    
    var body: Data? {
        switch self {
        case .getUser:
            return nil
        }
    }
    
    var needAuth: Bool {
        switch self {
        case .getUser:
            return true
        }
    }
}
