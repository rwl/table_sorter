import 'package:test/test.dart';
import 'package:table_sorter/src/utils.dart';

utilsTest() {
  group('utils', () {
    test('tryParseInt', () {
      expect(tryParseInt("3"), equals(3));
      expect(tryParseInt("this is a string"), isNull);
      expect(tryParseInt("3.0"), isNull);
    });
    test('tryParseDouble', () {
      expect(tryParseDouble("3"), equals(3.0));
      expect(tryParseDouble("exampleString"), isNull);
      expect(tryParseDouble("3.0"), equals(3.0));
    });
  });
}

void main() => utilsTest();
