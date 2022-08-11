// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Landing-Kit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Landing-Kit",
            targets: ["Landing-Kit"]),
    ],
    dependencies: [
        // SnapKit Depedency from GitHub for Auto Layout
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Landing-Kit",
            dependencies: ["SnapKit"]),
        .testTarget(
            name: "Landing-KitTests",
            dependencies: ["Landing-Kit"]),
    ]
)
