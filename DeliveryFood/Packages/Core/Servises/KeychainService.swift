import Foundation

public protocol KeychainServicable {
    func save(data: Data, key: KeychainKey) throws
    func read(key: KeychainKey) throws -> Data
}

public final class KeychainService {
    public init() {}
}

extension KeychainService: KeychainServicable {
    public func save(data: Data, key: KeychainKey) throws {
        let attributes = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
        ] as CFDictionary
        
        let status = SecItemAdd(attributes, nil)
        
        if status == errSecDuplicateItem {
            try update(data: data, key: key)
        } else {
            guard status == errSecSuccess else {
                throw KeychainServiceError.create
            }
        }
    }
    
    public func read(key: KeychainKey) throws -> Data {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        guard let data = result as? Data else {
            throw KeychainServiceError.read
        }
        return data
    }
    
    public func update(data: Data, key: KeychainKey) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
        ] as CFDictionary
        
        let attributes = [kSecValueData: data] as CFDictionary
        let status = SecItemUpdate(query, attributes)
        
        guard status == errSecSuccess else {
            throw KeychainServiceError.update
        }
    }
    
    public func delete(key: KeychainKey) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
        ] as CFDictionary
        
        let status = SecItemDelete(query)
        
        guard status == errSecSuccess else {
            throw KeychainServiceError.delete
        }
    }
}

enum KeychainServiceError: Error {
    case create
    case read
    case update
    case delete
}

public enum KeychainKey: String {
    case accessToken
    case refreshToken
    //    
    //    func tokenKey() -> TokenKey {
    //        switch self {
    //        case .accessToken:
    //            return .accessToken
    //        case .refreshToken:
    //            return .refreshToken
    //        }
    //    }
}


