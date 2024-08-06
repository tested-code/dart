import 'dart:mirrors';

import 'package:tested/src/_utils/faker_utils.dart';

/// Generates random parameters for a given list of parameters
extension InvokeAnnotatedX on DeclarationMirror {
  /// Generates random parameters for a given list of parameters
  void invokeAnnotated<T>(LibraryMirror lib) {
    if (!isTopLevel) {
      throw ArgumentError('Only top level methods are supported');
    }

    if (this is! MethodMirror) return;

    final type = this as MethodMirror;

    for (final meta in type.metadata) {
      if (meta.type.simpleName == Symbol(T.toString())) {
        // ignore: avoid_dynamic_calls
        for (var i = 0; i < (meta.reflectee.testcaseCount as int); i++) {
          final params = generateRandomParams(type.parameters);
          lib.invoke(type.simpleName, params);
        }
      }
    }
  }
}
