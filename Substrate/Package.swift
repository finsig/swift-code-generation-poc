// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Substrate",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Substrate",
            targets: ["Substrate"]),
    ],
    dependencies: [
        .package(url: "https://github.com/attaswift/BigInt.git", from: "5.3.0"),
        .package(url: "https://github.com/tesseract-one/swift-scale-codec.git", from: "0.2.1")
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Substrate",
            dependencies: [
                "BigInt",
                .product(name: "ScaleCodec", package: "swift-scale-codec")
            ],
            resources: [
                .process("Resources")
            ]),
        .testTarget(
            name: "SubstrateTests",
            dependencies: ["Substrate"]),
    ]
)
