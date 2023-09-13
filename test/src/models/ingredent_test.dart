import 'package:tech_task/src/models/ingredent.dart';
import 'package:test/test.dart';

void main() {
  group('Ingredent Model Test - ', () {
    test("Expected Values", () {
      final ingredent = Ingredent(
        title: "Test",
        date: DateTime(2023, 9, 13),
      );

      expect(
        ingredent,
        Ingredent(title: "Test", date: DateTime(2023, 9, 13)),
      );
    });
  });
}
