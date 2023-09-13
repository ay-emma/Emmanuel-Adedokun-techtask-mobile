import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
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

  @override
  List<Object?> get props => [title, ingredients];

  @override
  bool? get stringify => true;
}
