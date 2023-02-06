// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SourceKitD",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SourceKitD",
            targets: ["SourceKitD"]
        ),

    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-tools-support-core.git", branch: "main"),
    ],
    targets: [
        // SourceKitD: Swift bindings for sourcekitd.
        .target(
            name: "SourceKitD",
            dependencies: [
                "Csourcekitd",
                "LSPLogging",
                "SKSupport",
                .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core"),
            ],
            exclude: ["CMakeLists.txt"]
        ),

        // Csourcekitd: C modules wrapper for sourcekitd.
        .target(
            name: "Csourcekitd",
            dependencies: [],
            exclude: ["CMakeLists.txt"]
        ),

        // Logging support used in LSP modules.
        .target(
            name: "LSPLogging",
            dependencies: [],
            exclude: ["CMakeLists.txt"]
        ),
        
        // SKSupport: Data structures, algorithms and platform-abstraction code that might be generally
        // useful to any Swift package. Similar in spirit to SwiftPM's Basic module.
        .target(
            name: "SKSupport",
            dependencies: [
                .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core"),
            ],
            exclude: ["CMakeLists.txt"]
        ),
    ]
)
