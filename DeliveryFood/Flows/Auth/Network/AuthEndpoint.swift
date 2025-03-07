import Foundation
import Core

enum AuthEndpoint {
    case login(Data)
    case getUser
    case refresh
}

extension AuthEndpoint: Endpoint {
    var scheme: HTTPScheme {
        switch self {
        case .login, .getUser, .refresh:
            return .https
        }
    }
    
    var host: String {
        switch self {
        case .login, .getUser, .refresh:
            return "dummyjson.com"
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .getUser:
            return "/auth/me"
        case .refresh:
            return "/auth/refresh"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .refresh:
            return .post
        case .getUser:
            return .get
        }
    }
    
    var headers: [String : String] {
        var headers: [String : String] = [:]
        
        switch self {
        case .login, .refresh:
            headers["Content-Type"] = "application/json"
        case .getUser:
            break
        }
        return headers
    }
    
    var body: Data? {
        switch self {
        case let .login(data):
            return data
        case .getUser, .refresh:
            return nil
        }
    }
    
    var needAuth: Bool {
        switch self {
        case .login, .refresh:
            return false
        case .getUser:
            return true
        }
    }
}
