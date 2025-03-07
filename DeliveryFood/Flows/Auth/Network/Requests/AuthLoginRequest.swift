import Foundation

extension Auth {
    struct LoginRequest: Encodable {
        let username: String
        let password: String
    }
}
