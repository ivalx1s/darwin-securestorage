import Foundation
internal import KeychainAccess
internal import SecureStorageInterface

public extension SecureStorage {
    final actor Store {
        
        internal let isolatedSynchronizableKeychain: Keychain
        internal let isolatedNonSynchronizableKeychain: Keychain
        internal let sharedSynchronizableKeychain: Keychain
        internal let sharedNonSynchronizableKeychain: Keychain
        
        internal let decoder: JSONDecoder = .init()
        internal let encoder: JSONEncoder = .init()
        
        public init(
            isolatedAccessGroup: String,
            sharedAccessGroup: String,
            isolatedService: String,
            sharedService: String
        ) {
            self.isolatedSynchronizableKeychain = Keychain(
                service: isolatedService,
                accessGroup: isolatedAccessGroup
            ).synchronizable(true)
            
            self.isolatedNonSynchronizableKeychain = Keychain(
                service: isolatedService,
                accessGroup: isolatedAccessGroup
            ).synchronizable(false)
            
            self.sharedSynchronizableKeychain = Keychain(
                service: sharedService,
                accessGroup: sharedAccessGroup
            ).synchronizable(true)
            
            self.sharedNonSynchronizableKeychain = Keychain(
                service: sharedService,
                accessGroup: sharedAccessGroup
            ).synchronizable(false)
        }
    }
}
