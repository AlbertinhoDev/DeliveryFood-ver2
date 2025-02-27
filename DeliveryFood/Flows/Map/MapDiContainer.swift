import UIKit

extension Map {
    public protocol DiContainerable {
        var apiService: AuthAPIServicable { get }
    }
}

extension Map {
    public final class DiContainer: DiContainerable {
        
        public var apiService: AuthAPIServicable
        
        public init(apiService: AuthAPIServicable = AuthAPIService()) {
            self.apiService = apiService
        }
    }
}
