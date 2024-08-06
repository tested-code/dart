// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:tested/tested.dart';

void main() {
  group('Tested', () {
    test('can be instantiated', () {
      expect(Tested(), isNotNull);
    });
  });
}
