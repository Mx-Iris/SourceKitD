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
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "SourceKitD",
            targets: ["SourceKitD"]
        ),
    ],
    dependencies: [],
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
