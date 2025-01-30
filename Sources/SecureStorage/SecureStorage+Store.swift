import Foundation
internal import SecureStorage_KeychainAccess
import SecureStorageInterface

public extension SecureStorage {
    final actor Store {
        internal let isolatedSynchronizableKeychain: Keychain
        internal let isolatedNonSynchronizableKeychain: Keychain
        internal let sharedSynchronizableKeychain: Keychain
        internal let sharedNonSynchronizableKeychain: Keychain
        
        internal let decoder: JSONDecoder = .init()
        internal let encoder: JSONEncoder = .init()
        
        #if targetEnvironment(simulator)
        public init(
            isolatedAccessGroup: String,
            sharedAccessGroup: String,
            isolatedService: String,
            sharedService: String
        ) {
            // don't use accessGroup and syncronization
            self.isolatedSynchronizableKeychain = Keychain(service: isolatedService)
            self.isolatedNonSynchronizableKeychain = Keychain(service: isolatedService)
            self.sharedSynchronizableKeychain = Keychain(service: sharedService)
            self.sharedNonSynchronizableKeychain = Keychain(service: sharedService)
        }
        #else
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
#endif
    }
}
