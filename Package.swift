// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LandingKit",
    platforms: [.iOS(.v13)], // Target iOS Platforms & iOS Minimum Versions
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "LandingKit",
            targets: ["LandingKit"]),
    ],
    dependencies: [
        // Depedency for iOS & OS X Auto Layout from GitHub with Minimum Swift Version of 5.0.0
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.0.0")
    ],
    // Target Package with SnapKit
    targets: [
        .target(
            name: "LandingKit",
            dependencies: ["SnapKit"]),
        .testTarget(
            name: "LandingKitTests",
            dependencies: ["LandingKit"]),
    ]
)
