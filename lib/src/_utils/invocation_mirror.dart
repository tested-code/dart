import 'dart:mirrors';

import 'package:tested/src/_utils/faker_utils.dart';

/// Generates random parameters for a given list of parameters
extension InvokeAnnotated on LibraryMirror {
  /// Generates random parameters for a given list of parameters
  void invokeAnnotated<T>() {
    // ignore: no_leading_underscores_for_local_identifiers
    for (final _type in declarations.values) {
      if (_type is! MethodMirror) continue;

      if (!_type.isTopLevel) continue;

      for (final meta in _type.metadata) {
        if (meta.type.simpleName == Symbol(T.toString())) {
          // ignore: avoid_dynamic_calls
          for (var i = 0; i < (meta.reflectee.testcaseCount as int); i++) {
            final params = generateRandomParams(_type.parameters);
            invoke(_type.simpleName, params);
          }
        }
      }
    }
  }
}
