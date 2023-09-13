class Recipe {
  Recipe({required this.title, required this.ingredients});
  final String title;
  final List<String> ingredients;

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<String> nIngredents = json['ingredients'].cast<String>();
    return Recipe(
      title: json['title'],
      ingredients: nIngredents,
    );
  }
}
