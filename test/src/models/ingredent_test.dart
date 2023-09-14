import 'package:tech_task/src/models/ingredent.dart';
import 'package:test/test.dart';

void main() {
  group("Test Ingredient class - ", () {
    test('Test Ingredient Class Serelization and Deserelization', () {
      // Create a sample JSON map representing an Ingredient
      final json = {
        'title': 'Ingredient 1',
        'use-by': '2022-12-31', // Use a future date for testing
      };

      // Create an Ingredent object from the JSON map
      final ingredient = Ingredent.fromJson(json);

      // Verify that the title and date of the Ingredient are correct
      expect(ingredient.title, 'Ingredient 1');
      expect(ingredient.date.year, 2022);
      expect(ingredient.date.month, 12);
      expect(ingredient.date.day, 31);

      // Convert the Ingredient object to a JSON map
      final ingredientJson = ingredient.toJson();

      // Verify that the JSON map matches the original JSON map
      expect(ingredientJson['title'], 'Ingredient 1');
      expect(ingredientJson['use-by'], "2022-12-31 00:00:00.000");
    });

    test('Test Ingredient Equatable', () {
      // Create two Ingredent objects with the same values
      final now = DateTime.now(); // to prevent issues with the little diff
      // in time of execution of each step
      final ingredient1 = Ingredent(title: 'Ingredient 1', date: now);
      final ingredient2 = Ingredent(title: 'Ingredient 1', date: now);

      // Verify that the two objects are equal
      expect(ingredient1, ingredient2);

      // Create two Ingredent objects with different titles
      final ingredient3 = Ingredent(title: 'Ingredient 1', date: now);
      final ingredient4 = Ingredent(title: 'Ingredient 2', date: now);

      // Verify that the two objects are not equal
      expect(ingredient3, isNot(ingredient4));

      // Create two Ingredent objects with different dates
      final ingredient5 =
          Ingredent(title: 'Ingredient 1', date: DateTime(2022, 1, 1));
      final ingredient6 =
          Ingredent(title: 'Ingredient 1', date: DateTime(2022, 1, 2));

      // Verify that the two objects are not equal
      expect(ingredient5, isNot(ingredient6));
    });
  });
}
