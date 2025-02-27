import Foundation

public protocol EncoderServicable {
    func encode(value: Encodable) throws -> Data
}

public final class EncoderService {
    public init() {}
}

extension EncoderService: EncoderServicable {
    public func encode(value: Encodable) throws -> Data {
        return try JSONEncoder().encode(value)
    }
}
