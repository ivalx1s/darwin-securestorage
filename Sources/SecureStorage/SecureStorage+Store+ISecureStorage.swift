import SecureStorageInterface
import Foundation

extension SecureStorage.Store: SecureStorage.ISecureStorage {
    public func removeSecureStoreValue(
        for key: any SecureStorage.KeyConvertible,
        container: SecureStorage.ContainerType = .isolatedContainer,
        scope: SecureStorage.Scope = .local
    ) async {
        let eraser: String? = nil
        self[key: key, container: container, scope: scope] = eraser
    }
    
    public func setSecureStoreValue<T: Codable>(
        _ value: T?,
        for key: any SecureStorage.KeyConvertible,
        container: SecureStorage.ContainerType,
        scope: SecureStorage.Scope
    ) async {
        self[key: key, container: container, scope: scope] = value
    }
    
    public func getSecureStoreValue<T: Codable>(
        for key: any SecureStorage.KeyConvertible,
        container: SecureStorage.ContainerType = .isolatedContainer,
        scope: SecureStorage.Scope = .local
    ) async -> T? {
        self[key: key, container: container, scope: scope]
    }
    
    public subscript<T: Codable>(
        key secureKey: any SecureStorage.KeyConvertible,
        container container: SecureStorage.ContainerType,
        scope scope: SecureStorage.Scope
    ) -> T? {
        get {
            switch container {
            case .isolatedContainer:
                switch scope {
                case .local:
                    let keychain = self.isolatedNonSynchronizableKeychain
                    guard let rawValue = keychain[secureKey.key] else { return nil }
                    return try? self.decoder.decode(T.self, from: Data(rawValue.utf8))
                case .cloud:
                    let keychain = self.isolatedSynchronizableKeychain
                    guard let rawValue = keychain[secureKey.key] else { return nil }
                    return try? self.decoder.decode(T.self, from: Data(rawValue.utf8))
                }
                
            case .sharedContainer:
                switch scope {
                case .local:
                    let keychain = self.sharedNonSynchronizableKeychain
                    guard let rawValue = keychain[secureKey.key] else { return nil }
                    return try? self.decoder.decode(T.self, from: Data(rawValue.utf8))
                    
                case .cloud:
                    let keychain = self.sharedSynchronizableKeychain
                    guard let rawValue = keychain[secureKey.key] else { return nil }
                    return try? self.decoder.decode(T.self, from: Data(rawValue.utf8))
                }
            }
        }
        
        set {
            switch container {
            case .isolatedContainer:
                switch scope {
                case .local:
                    let keychain = self.isolatedNonSynchronizableKeychain
                    do {
                        guard let value = newValue else {
                            try keychain.remove(secureKey.key)
                            return
                        }
                        let rawValue = try encoder.encode(value)
                        guard let string = String(data: rawValue, encoding: .utf8) else { return }
                        keychain[secureKey.key] = string
                    } catch {}
                    
                case .cloud:
                    let keychain = self.isolatedSynchronizableKeychain
                    do {
                        guard let value = newValue else {
                            try keychain.remove(secureKey.key)
                            return
                        }
                        let rawValue = try encoder.encode(value)
                        guard let string = String(data: rawValue, encoding: .utf8) else { return }
                        keychain[secureKey.key] = string
                    } catch {}
                }
                
            case .sharedContainer:
                switch scope {
                case .local:
                    let keychain = self.sharedNonSynchronizableKeychain
                    do {
                        guard let value = newValue else {
                            try keychain.remove(secureKey.key)
                            return
                        }
                        let rawValue = try encoder.encode(value)
                        guard let string = String(data: rawValue, encoding: .utf8) else { return }
                        keychain[secureKey.key] = string
                    } catch {}
                    
                case .cloud:
                    let keychain = self.sharedSynchronizableKeychain
                    do {
                        guard let value = newValue else {
                            try keychain.remove(secureKey.key)
                            return
                        }
                        let rawValue = try encoder.encode(value)
                        guard let string = String(data: rawValue, encoding: .utf8) else { return }
                        keychain[secureKey.key] = string
                    } catch {}
                }
            }
        }
    }
}

extension SecureStorage.Store {
    
}
