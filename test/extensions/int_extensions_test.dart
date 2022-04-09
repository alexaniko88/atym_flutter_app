import 'package:atym_flutter_app/extensions/int_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('Int extensions test ', () {
    test('test isBetween', () async {
      bool result = 10.isBetween(from: 0, to: 11);
      expect(result, true);

      result = 10.isBetween(from: 10, to: 11);
      expect(result, true);

      result = 10.isBetween(from: 11, to: 12);
      expect(result, false);

      result = 10.isBetween(from: 0, to: 5);
      expect(result, false);
    });
  });
}
