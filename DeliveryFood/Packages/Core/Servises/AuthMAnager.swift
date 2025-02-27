import Foundation

public protocol AuthManagable {
    func fetchAccessToken() throws -> String
    func save(accessToken: String, refreshToken: String) throws
}

public final class AuthManager {
    private let keychainService: KeychainServicable
    private let encoderService: EncoderServicable
    private let decoderService: DecoderServicable
    
    public init(
        keychainService: KeychainServicable = KeychainService(),
        encoderService: EncoderServicable = EncoderService(),
        decoderService: DecoderServicable = DecoderService()
    ) {
        self.keychainService = keychainService
        self.encoderService = encoderService
        self.decoderService = decoderService
    }
    
    private func save(token: String, key: TokenKey) throws {
        let data  = try encoderService.encode(value: token)
        try keychainService.save(data: data, key: key.keychainKey())
    }
}

extension AuthManager: AuthManagable {
    public func fetchAccessToken() throws -> String {
        let data = try keychainService.read(key: .accessToken)
        return try decoderService.decode(data: data)
    }
    
    public func save(accessToken: String, refreshToken: String) throws {
        try save(token: accessToken, key: .accessToken)
        try save(token: refreshToken, key: .refreshToken)
    }
}

public enum TokenKey: String {
    case accessToken
    case refreshToken

    func keychainKey() -> KeychainKey {
        switch self {
        case .accessToken:
            return .accessToken
        case .refreshToken:
            return .refreshToken
        }
    }
}
