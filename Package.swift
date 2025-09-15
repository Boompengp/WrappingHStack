// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WrappingHStack",
    platforms: [
        .iOS(.v14), .macOS(.v11)
    ],
    products: [
        .library(
            name: "WrappingHStack",
            targets: ["WrappingHStack"]
        ),
    ],
    targets: [
        .target(
            name: "WrappingHStack",
            dependencies: []
        ),
        .testTarget(
            name: "WrappingHStackTests",
            dependencies: ["WrappingHStack"]
        ),
    ]
)
