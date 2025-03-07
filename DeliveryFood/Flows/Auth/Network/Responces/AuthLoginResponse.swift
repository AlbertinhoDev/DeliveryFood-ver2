import Foundation

extension Auth {
    public struct LoginResponse: Decodable {
        let accessToken: String
        let refreshToken: String
    }
}


