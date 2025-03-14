import Foundation

public final class NetworkService {
    private let tokenManager: TokenManagable
    
    public init(authManager: TokenManagable = TokenManager()) {
        self.tokenManager = authManager
    }
}

extension NetworkService: Networkable {
   
    public func request(endpoint: Endpoint) async throws -> Data {
        let urlRequest = try makeURLRequest(endpoint: endpoint)
        let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
        guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        switch httpURLResponse.statusCode {
        case 200...299:
            return data
//        case 401:
//            break
        default:
            throw URLError(.badServerResponse)
        }
    }
    
    private func makeURLRequest(endpoint: Endpoint) throws -> URLRequest {
        let url = try makeURL(endpoint: endpoint)
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.httpBody = endpoint.body
        
        endpoint.headers.forEach {
            urlRequest.setValue($1, forHTTPHeaderField: $0)
        }

        if endpoint.needAuth {
            let accessToken = try tokenManager.fetchAccessToken()
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
                
        return urlRequest
    }
    
    private func makeURL(endpoint: Endpoint) throws -> URL {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.host
        components.path = endpoint.path
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        print(url.absoluteString)
        return url
    }
}
