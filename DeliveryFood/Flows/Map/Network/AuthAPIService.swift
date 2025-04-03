import Foundation
import Core

public protocol AuthAPIServicable {
    func login(username: String, password: String) async throws -> AuthLoginResponse
    func getUser() async throws -> AuthUserResponse
}

public final class AuthAPIService {
    private let encoderService: EncoderServicable
    private let decoderService: DecoderServicable
    private let networkService: Networkable
    private let tokenManager: TokenManagable
    
    public init(
        encoderService: EncoderServicable = EncoderService(),
        decoderService: DecoderServicable = DecoderService(),
        keychainService: KeychainServicable = KeychainService()
    ) {
        self.encoderService = encoderService
        self.decoderService = decoderService
        self.tokenManager = TokenManager(
            keychainService: keychainService,
            encoderService: encoderService,
            decoderService: decoderService
        )
        networkService = NetworkService(authManager: tokenManager)
    }
}

extension AuthAPIService: AuthAPIServicable {
    public func getUser() async throws -> AuthUserResponse {
        let endpoint = AuthEndpoint.getUser
        let data = try await networkService.request(endpoint: endpoint)
        
        return try decoderService.decode(data: data)
    }
    
    public func login(username: String, password: String) async throws -> AuthLoginResponse {
        let request = AuthLoginRequest(username: username, password: password)
        let bodyData = try encoderService.encode(value: request)
        let endpoint = AuthEndpoint.login(bodyData)
        let data = try await networkService.request(endpoint: endpoint)
        
        let response: AuthLoginResponse = try decoderService.decode(data: data)
        try tokenManager.save(accessToken: response.accessToken, refreshToken: response.refreshToken)
        
        return response
    }
}
