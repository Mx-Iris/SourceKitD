// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

var globalSwiftSettings: [SwiftSetting] {
    let result: [SwiftSetting] = [
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
    ]
    return result
}

let package = Package(
    name: "SourceKitD",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "SourceKitD",
            targets: ["SourceKitD"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-crypto.git", from: "3.0.0"),
    ],
    targets: [
        // SourceKitD: Swift bindings for sourcekitd.
        .target(
            name: "SourceKitD",
            dependencies: [
                "Csourcekitd",
                "SKLogging",
                "SwiftExtensions",
            ],
            exclude: ["CMakeLists.txt", "sourcekitd_uids.swift.gyb"],
            swiftSettings: globalSwiftSettings
        ),
        .target(
            name: "SKLogging",
            dependencies: [
                "SwiftExtensions",
                .product(name: "Crypto", package: "swift-crypto"),
            ],
            exclude: ["CMakeLists.txt"],
            swiftSettings: globalSwiftSettings
        ),
        .target(
            name: "SwiftExtensions",
            dependencies: ["CAtomics"],
            exclude: ["CMakeLists.txt"],
            swiftSettings: globalSwiftSettings
        ),
        .target(
            name: "Csourcekitd",
            dependencies: [],
            exclude: ["CMakeLists.txt"]
        ),

        .target(
            name: "CAtomics",
            dependencies: []
        ),
    ]
)
