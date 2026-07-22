// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "RepdModules",
    platforms: [
        .iOS(.v18),
        // macOS is declared only so the package builds/tests on the host
        // (swift build/test); the app ships iOS-only.
        .macOS(.v13),
    ],
    products: [
        .library(name: "RepdDesignSystem", targets: ["RepdDesignSystem"]),
        .library(name: "RepdCore", targets: ["RepdCore"]),
        .library(name: "RepdData", targets: ["RepdData"]),
        .library(name: "RepdFeatures", targets: ["RepdFeatures"]),
    ],
    dependencies: [
        .package(url: "https://github.com/groue/GRDB.swift.git", from: "7.0.0"),
    ],
    targets: [
        // Leaf modules
        .target(name: "RepdDesignSystem"),
        .target(name: "RepdCore"),
        .target(
            name: "RepdData",
            dependencies: [
                .product(name: "GRDB", package: "GRDB.swift"),
            ]
        ),

        // Feature layer
        .target(
            name: "RepdFeatures",
            dependencies: ["RepdData", "RepdCore", "RepdDesignSystem"]
        ),

        // One test target per module
        .testTarget(name: "RepdDesignSystemTests", dependencies: ["RepdDesignSystem"]),
        .testTarget(name: "RepdCoreTests", dependencies: ["RepdCore"]),
        .testTarget(name: "RepdDataTests", dependencies: ["RepdData"]),
        .testTarget(name: "RepdFeaturesTests", dependencies: ["RepdFeatures"]),
    ]
)
