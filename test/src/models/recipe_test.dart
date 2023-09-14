import 'package:tech_task/src/models/recipe.dart';
import 'package:test/test.dart';

void main() {
  group('Recipe Model Test - ', () {
    test('Test Recipe Class', () {
      // Create a sample JSON map representing a Recipe
      final json = {
        'title': 'Recipe 1',
        'ingredients': ['Ingredient A', 'Ingredient B'],
      };

      // Create a Recipe object from the JSON map
      final recipe = Recipe.fromJson(json);

      // Verify that the title and ingredients of the Recipe are correct
      expect(recipe.title, 'Recipe 1');
      expect(recipe.ingredients, ['Ingredient A', 'Ingredient B']);
    });

    test('Test Recipe Equatable', () {
      // Create two Recipe objects with the same values
      final recipe1 = Recipe(
          title: 'Recipe 1', ingredients: ['Ingredient A', 'Ingredient B']);
      final recipe2 = Recipe(
          title: 'Recipe 1', ingredients: ['Ingredient A', 'Ingredient B']);

      // Verify that the two objects are equal
      expect(recipe1, recipe2);

      // Create two Recipe objects with different titles
      final recipe3 = Recipe(
          title: 'Recipe 1', ingredients: ['Ingredient A', 'Ingredient B']);
      final recipe4 = Recipe(
          title: 'Recipe 2', ingredients: ['Ingredient A', 'Ingredient B']);

      // Verify that the two objects are not equal
      expect(recipe3, isNot(recipe4));

      // Create two Recipe objects with different ingredients
      final recipe5 = Recipe(
          title: 'Recipe 1', ingredients: ['Ingredient A', 'Ingredient B']);
      final recipe6 = Recipe(
          title: 'Recipe 1', ingredients: ['Ingredient C', 'Ingredient D']);

      // Verify that the two objects are not equal
      expect(recipe5, isNot(recipe6));
    });
  });
}
