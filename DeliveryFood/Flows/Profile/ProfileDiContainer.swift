import UIKit

extension Profile {
    public protocol DiContainerable {
        var apiService: APIServicable { get }
    }
}

extension Profile {
    public final class DiContainer: DiContainerable {
        
        public var apiService: APIServicable
        
        public init(apiService: APIServicable = APIService()) {
            self.apiService = apiService
        }
    }
}
