import Foundation

public struct AuthLoginResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}
