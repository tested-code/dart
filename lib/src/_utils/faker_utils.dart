import 'dart:mirrors' as reflector;
import 'package:faker/faker.dart' as faker;

final _cases = <Type, dynamic Function()>{
  int: () => faker.random.integer(100),
  String: () => faker.random.string(100),
  double: faker.random.decimal,
  bool: faker.random.boolean,
};

/// Generates random parameters for a given list of parameters
List<dynamic> generateRandomParams(
  List<reflector.ParameterMirror> params,
) {
  return [
    for (final param in params) _cases[param.type.reflectedType]?.call(),
  ];
}
