import Foundation

public protocol DecoderServicable {
    func decode <T: Decodable>(data: Data) throws -> T
}

public final class DecoderService {
    public init() {}
}

extension DecoderService: DecoderServicable {
    public func decode <T: Decodable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
