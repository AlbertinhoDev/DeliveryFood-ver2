import Foundation

public protocol Networkable {
    func request(endpoint: Endpoint) async throws -> Data
}
