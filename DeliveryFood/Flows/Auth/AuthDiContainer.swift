import UIKit

extension Auth {
    public protocol DiContainerable {
        var apiService: Auth.APIServicable { get }
    }
}

extension Auth {
    public final class DiContainer: DiContainerable {
        public var apiService: Auth.APIServicable
        
        public init(apiService: Auth.APIServicable = Auth.APIService()) {
            self.apiService = apiService
        }
    }
}
