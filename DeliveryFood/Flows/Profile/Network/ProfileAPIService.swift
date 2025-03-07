import Foundation
import Core

extension Profile {
    public protocol APIServicable {
        func getUser() async throws -> Profile.UserResponse
    }
}

extension Profile {
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




extension Profile.APIService: Profile.APIServicable {
    public func getUser() async throws -> Profile.UserResponse {
        let endpoint = Profile.Endpoint.getUser
        let data = try await networkService.request(endpoint: endpoint)
        
        return try decoderService.decode(data: data)
    }
}
