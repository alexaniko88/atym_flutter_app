import 'package:atym_flutter_app/extensions/int_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('Int extensions test ', () {
    test('test isBetween', () async {
      bool result = 10.isBetween(from: 10, to: 0);
      expect(result, true);

      result = 10.isBetween(from: 11, to: 10);
      expect(result, true);

      result = 10.isBetween(from: 12, to: 11);
      expect(result, false);

      result = 10.isBetween(from: 5, to: 0);
      expect(result, false);
    });
  });
}
