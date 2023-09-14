import 'package:flutter/material.dart';
import 'package:tech_task/src/models/api_response.dart';
import 'package:tech_task/src/models/ingredent.dart';
import 'package:tech_task/src/models/recipe.dart';
import 'package:tech_task/src/repository/launch_repo.dart';
import 'package:tech_task/src/repository/network_api.dart';

class RecipePage extends StatefulWidget {
  const RecipePage(
      {super.key, required this.ingredients, required this.networkInterface});
  final List<Ingredent> ingredients;
  final NetworkInterface networkInterface;
  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  late Future<ApiResponse> recipe;
  @override
  void initState() {
    super.initState();
    String recipes = widget.ingredients.join(",");
    recipe = LaunchRepo(widget.networkInterface)
        .getRecipes({"ingredients": recipes});
  }

  @override
  Widget build(BuildContext context) {
    print(widget.ingredients);
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Recipe"),
      ),
      body: FutureBuilder(
        future: recipe,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }

          //got some data
          if (snapshot.hasData) {
            final response = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: switch (response) {
                Error() => Center(child: Text(response.message)),
                Success<List<Recipe>>() => ListView.builder(
                    itemCount: response.data.length,
                    itemBuilder: (context, index) {
                      final value = response.data[index];
                      return ExpansionTile(
                        title: Text(value.title),
                        children: [
                          for (final ingredent in value.ingredients)
                            Text(ingredent),
                        ],
                      );
                    }),
                _ => Center(
                    child: Text("Can't find match"),
                  )
              },
            );
          }
          //
          else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error!.toString()),
            );
          }
          return Center(
            child: Text("Can't find match"),
          );
        },
      ),
    );
  }
}
