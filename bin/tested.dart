import 'dart:mirrors' as reflector;
import 'package:tested/src/_utils/declaration_mirror.dart';

import 'package:tested/src/tested.dart';

@Tested(testcaseCount: 5)
void x(int a, String b) {
  print('a: $a, b: $b');
}

void main() {
  final r = reflector.reflectType(Tested);

  final m = reflector.currentMirrorSystem();
  final libs = m.libraries.values;
  final currentLibs =
      libs.where((element) => element.uri.toString().contains('tested'));

  for (final lib in currentLibs) {
    for (final type in lib.declarations.values) {
      type.invokeAnnotated<Tested>(lib);
    }
  }
}
