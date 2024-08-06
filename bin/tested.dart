import 'dart:mirrors' as reflector;

import 'package:tested/src/_utils/invocation_mirror.dart';
import 'package:tested/src/tested.dart';

@Tested(testcaseCount: 5)
void x(int a, int b) {
  assert(add(a, b) != a + b, '');
}

int add(int a, int b) {
  return a + b;
}

void main() {
  final m = reflector.currentMirrorSystem();
  final libs = m.libraries.values;

  for (final lib in libs) {
    lib.invokeAnnotated<Tested>();
  }
}
