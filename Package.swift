// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "BPWeatherKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .macCatalyst(.v16),
        .watchOS(.v9),
        .tvOS(.v16)
    ],
    products: [
        .library(
            name: "BPWeatherKit",
            targets: ["BPWeatherKit"]
        )
    ],
    targets: [
        .target(
            name: "BPWeatherKit",
            dependencies: [],
            swiftSettings: [
                .unsafeFlags(["-strict-concurrency=complete"])
            ]
        )
    ]
)
