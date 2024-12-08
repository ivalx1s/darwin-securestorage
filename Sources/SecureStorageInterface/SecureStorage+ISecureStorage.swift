
public extension SecureStorage {
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    protocol ISecureStorage: Sendable, Actor {
        
        func setSecureStoreValue<T: Codable>(
            _ value: T?,
            for key: any SecureStorage.KeyConvertible,
            container: SecureStorage.ContainerType,
            scope: SecureStorage.Scope
        ) async
        
        func getSecureStoreValue<T: Codable>(
            for key: any SecureStorage.KeyConvertible,
            container: SecureStorage.ContainerType,
            scope: SecureStorage.Scope
        ) async -> T?
        
        func removeSecureStoreValue(
            for key: any SecureStorage.KeyConvertible,
            container: SecureStorage.ContainerType,
            scope: SecureStorage.Scope
        ) async
        
        subscript<T: Codable>(
            key key: any SecureStorage.KeyConvertible,
            container container: SecureStorage.ContainerType,
            scope scope: SecureStorage.Scope
        ) -> T? { get set }
    }
}
