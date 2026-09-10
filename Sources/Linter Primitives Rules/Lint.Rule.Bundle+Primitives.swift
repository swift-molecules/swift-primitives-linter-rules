public import Linter_Institute_Rules
public import Lint
public import Primitives_Linter_Rule_Tower

extension Lint.Rule.Bundle {

  public static let primitives: [Lint.Rule.Configuration] =
    Lint.Rule.Bundle.institute + [

      .enable(.`frozen tower type`),
      .enable(.`clone-less box`),

      .enable(.`carrier column bound`),
    ]
}
