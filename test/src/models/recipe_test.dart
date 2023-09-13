import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/src/models/recipe.dart';

void main() {
  group('Recipe Model Test - ', () {
    test("Expected Values", () {
      final recipe = Recipe(title: "Test", ingredients: ["Test1", "Test2"]);

      expect(
        recipe,
        Recipe(title: "Test", ingredients: ["Test1", "Test2"]),
      );
    });
  });
}
