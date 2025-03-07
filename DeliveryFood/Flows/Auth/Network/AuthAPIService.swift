import Foundation
import Core

extension Auth {
    public protocol APIServicable {
        func login(username: String, password: String) async throws -> Auth.LoginResponse
    }
}

extension Auth {
    public final class APIService {
        private let encoderService: EncoderServicable
        private let decoderService: DecoderServicable
        private let networkService: Networkable
        private let authManager: TokenManagable
        
        public init(
            encoderService: EncoderServicable = EncoderService(),
            decoderService: DecoderServicable = DecoderService(),
            keychainService: KeychainServicable = KeychainService()
        ) {
            self.encoderService = encoderService
            self.decoderService = decoderService
            self.authManager = TokenManager(
                keychainService: keychainService,
                encoderService: encoderService,
                decoderService: decoderService
            )
            
            networkService = NetworkService(authManager: authManager)
        }
    }
}

extension Auth.APIService: Auth.APIServicable {
    public func login(username: String, password: String) async throws -> Auth.LoginResponse {
        let request = Auth.LoginRequest(username: username, password: password)
        let bodyData = try encoderService.encode(value: request)
        let endpoint = AuthEndpoint.login(bodyData)
        let data = try await networkService.request(endpoint: endpoint)
        
        let response: Auth.LoginResponse = try decoderService.decode(data: data)
        try authManager.save(accessToken: response.accessToken, refreshToken: response.refreshToken)
        
        return response
    }
}
