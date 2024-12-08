// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "darwin-securestorage",
    platforms: [
        .iOS(.v15),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "SecureStorage",
			type: .dynamic,
            targets: ["SecureStorage"]
		),
        .library(
            name: "SecureStorageInterface",
            type: .dynamic,
            targets: ["SecureStorageInterface"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SecureStorage",
            dependencies: ["SecureStorage_KeychainAccess", "SecureStorageInterface"]
		),
        .target(
            name: "SecureStorageInterface",
            dependencies: []
        ),
        .target(
            name: "SecureStorage_KeychainAccess",
            dependencies: []
        ),
    ]
)
