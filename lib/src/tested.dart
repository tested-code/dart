/// {@template tested}
/// generates test cases for annotated function with various rule based inputs
/// {@endtemplate}
const tested = Tested();

/// {@template tested}
/// generates test cases for annotated function with various rule based inputs
/// {@endtemplate}
class Tested {
  /// {@macro tested}
  const Tested({this.testcaseCount = 10});

  /// {@template tested.testcaseCount}
  /// the number of testcases to generate.
  /// defaults to 10 or reads value from config if it exists
  /// {@endtemplate}
  final int testcaseCount;
}

/// {@template tested.symbol}
/// the symbol used to identify the annotation
/// {@endtemplate}
const testedSymbol = Symbol('Tested');
