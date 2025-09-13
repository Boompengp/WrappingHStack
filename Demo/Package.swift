// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "WrappingHStackDemo",
    platforms: [.iOS(.v14)],
    dependencies: [
        .package(path: "..")
    ],
    targets: [
        .target(
            name: "WrappingHStackDemo",
            dependencies: [
                .product(name: "WrappingHStack", package: "WrappingHStack")
            ],
            path: "Sources"
        )
    ]
)