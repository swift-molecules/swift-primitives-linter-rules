// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-primitives-linter-rules",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [

        .library(
            name: "Primitives Linter Rule Tower",
            targets: ["Primitives Linter Rule Tower"]
        ),

        .library(
            name: "Linter Primitives Rules",
            targets: ["Linter Primitives Rules"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-molecules/swift-lint.git", branch: "main"),
        .package(url: "https://github.com/swift-compositions/swift-institute-linter-rules.git", branch: "main"),
        .package(url: "https://github.com/swift-compositions/swift-linter-rules.git", branch: "main"),
        .package(url: "https://github.com/swiftlang/swift-syntax.git", "603.0.2"..<"604.0.0"),
    ],
    targets: [
        .target(
            name: "Primitives Linter Rule Tower",
            dependencies: [
                .product(name: "Lint", package: "swift-lint"),
                .product(name: "SwiftSyntax", package: "swift-syntax"),
            ]
        ),
        .target(
            name: "Linter Primitives Rules",
            dependencies: [
                .product(name: "Lint", package: "swift-lint"),
                .target(name: "Primitives Linter Rule Tower"),
                .product(name: "Linter Institute Rules", package: "swift-institute-linter-rules"),
            ]
        ),
        .testTarget(
            name: "Primitives Linter Rule Tower Tests",
            dependencies: [
                .target(name: "Primitives Linter Rule Tower"),
                .product(name: "Linter Rules Test Support", package: "swift-linter-rules"),
                .product(name: "SwiftParser", package: "swift-syntax"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    target.swiftSettings = (target.swiftSettings ?? []) + [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableExperimentalFeature("Lifetimes"),
        .treatAllWarnings(as: .error),
    ]
}
