// swift-tools-version: 6.3.3

// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-primitives-linter-rules open source project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the swift-primitives-linter-rules project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

import PackageDescription

let package = Package(
    name: "swift-primitives-linter-rules",
    platforms: [
        .macOS("27"),
        .iOS("27"),
        .tvOS("27"),
        .watchOS("27"),
        .visionOS("27"),
    ],
    products: [
        // A5 move (2026-07-07) — the RawValue and Cardinal brand-consumer
        // packs relocated to swift-institute-linter-rules so they enforce at
        // standards/compositions too. Only the tower-author rules
        // (genuinely molecule-layer-only) remain.
        // Round M ζ pilot (2026-06-12) — tower-scoped structural rules.
        .library(
            name: "Primitives Linter Rule Tower",
            targets: ["Primitives Linter Rule Tower"]
        ),

        // Aggregate bundle — publishes `Lint.Rule.Bundle.primitives`
        // (= institute + molecule-layer rules). Molecule-layer
        // consumers depend on this product alone.
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

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem
}
