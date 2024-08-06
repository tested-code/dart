import 'dart:mirrors' as reflector;
import 'package:faker/faker.dart' as faker;

import 'package:tested/src/tested.dart';

@Tested(testcaseCount: 5)
void x(int a, String b) {
  print('a: $a, b: $b');
}

final cases = {
  int: () => faker.random.integer(100),
  String: () => faker.random.string(100),
  double: faker.random.decimal,
  bool: faker.random.boolean,
};

List<dynamic> _generateRandomParams(
  List<reflector.ParameterMirror> params,
) {
  return [
    for (final param in params) cases[param.type.reflectedType]?.call(),
  ];
}

void main() {
  final r = reflector.reflectType(Tested);
  final m = reflector.currentMirrorSystem();
  final libs = m.libraries.values;
  final currentLibs =
      libs.where((element) => element.uri.toString().contains('tested'));

  for (final lib in currentLibs) {
    for (final type in lib.declarations.values) {
      type.invokeAnnotated(lib);
    }
    // final r = [
    //   for (final MapEntry(key: lib, value: declaration) in m.libraries.entries)
    //     for (final MapEntry(key: type, value: declaration)
    //         in declaration.declarations.entries)
    //       declaration.metadata.any
    // ];
    // print(r);
  }
}

extension InvokeAnnotatedX on reflector.DeclarationMirror {
  void invokeAnnotated(reflector.LibraryMirror lib) {
    if (!isTopLevel) {
      throw ArgumentError('Only top level methods are supported');
    }

    if (this is! reflector.MethodMirror) return;

    final type = this as reflector.MethodMirror;

    for (final meta in type.metadata) {
      if (meta.type.simpleName == testedSymbol) {
        // ignore: avoid_dynamic_calls
        for (var i = 0; i < (meta.reflectee.testcaseCount as int); i++) {
          final params = _generateRandomParams(type.parameters);
          lib.invoke(type.simpleName, params);
        }
      }
    }
  }
}

extension on String {
  String chopBetween(String start, String end) {
    var ret = '';
    var startFound = false;
    for (final char in split('')) {
      if (startFound && char == end) break;

      if (!startFound && char == start) {
        startFound = true;
        continue;
      }

      if (startFound) {
        ret += char;
      }
    }

    return ret;
  }
}
