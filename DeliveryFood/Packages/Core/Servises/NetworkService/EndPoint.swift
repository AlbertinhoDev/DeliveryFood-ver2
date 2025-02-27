import Foundation

public protocol Endpoint {
    var scheme: HTTPScheme { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    var needAuth: Bool { get }
}
