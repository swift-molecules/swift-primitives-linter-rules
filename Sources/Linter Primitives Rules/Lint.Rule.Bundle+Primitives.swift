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

public import Linter_Institute_Rules
public import Lint
public import Primitives_Linter_Rule_Tower

/// Molecule-layer rule bundle.
///
/// Equals the institute-tier bundle (which transitively includes the
/// universal bundle) plus molecule-layer rules currently living in
/// `swift-primitives-linter-rules`. A molecule-layer consumer pulls
/// this single product and references the bundle by name:
///
/// ```swift
/// let configuration = Lint.Configuration {
///     Lint.Rule.Bundle.primitives
/// }
/// ```
///
/// The bundle is the single source of truth for "which rules apply at
/// the molecule layer". Adding a new rule to this package extends
/// this bundle; consumers pick up the new rule automatically on their
/// next dependency-resolution.
extension Lint.Rule.Bundle {
  /// The molecule-layer rule bundle: the institute-tier bundle plus the Tower rule pack.
  ///
  /// A5 move (2026-07-07, principal ruling): the Cardinal and RawValue
  /// brand-consumer packs relocated to swift-institute-linter-rules so they
  /// enforce in standards/compositions too (brands are defined in molecules but consumed
  /// everywhere) — they now arrive here transitively via
  /// `Lint.Rule.Bundle.institute`, leaving effective molecule-layer coverage unchanged.
  /// Precedent: [PRIM-FOUND-001] made the same primitives→institute move
  /// mid-pilot. Only the tower-author rules (genuinely molecule-layer-only) remain in
  /// this package.
  public static let primitives: [Lint.Rule.Configuration] =
    Lint.Rule.Bundle.institute + [
      // Tower pack (Round M ζ pilot 2026-06-12)
      .enable(.`frozen tower type`),
      .enable(.`clone-less box`),
      // [DS-026](a) direct type-level seam-bound (/promote-rule 2026-07-06)
      .enable(.`carrier column bound`),
    ]
}
