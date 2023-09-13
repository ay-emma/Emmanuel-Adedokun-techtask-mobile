import 'package:tech_task/src/models/recipe.dart';
import 'package:test/test.dart';

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
