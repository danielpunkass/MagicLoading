// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MagicLoading",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "MagicLoading",
            targets: ["MagicLoading"]),
    ],
    targets: [
        .target(
            name: "MagicLoading",
            dependencies: []),
        .testTarget(
            name: "MagicLoadingTests",
            dependencies: ["MagicLoading"]),
    ]
)
