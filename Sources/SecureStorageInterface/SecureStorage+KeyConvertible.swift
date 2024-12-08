

public extension SecureStorage {
    protocol KeyConvertible: Sendable {
        var key: String { get }
    }
}
