import 'package:tech_task/src/models/api_response.dart';
import 'package:tech_task/src/models/ingredent.dart';
import 'package:tech_task/src/models/recipe.dart';
import 'package:tech_task/src/repository/network_api.dart';

class LaunchRepo {
  LaunchRepo(this.network);
  final NetworkInterface network;

  Future<ApiResponse> getIngredents() async {
    final response = await network.get("/ingredients");
    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return Success<List<Ingredent>>(
          data: data.map((e) => Ingredent.fromJson(e)).toList());
    } else {
      return Error(
          message:
              "Error getting ingredents - StatusCode: ${response.statusCode}");
    }
  }

  Future<ApiResponse> getRecipes(Map<String, dynamic> queryParameters) async {
    final response = await network.get("/recipes", queryParameters);
    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return Success<List<Recipe>>(
          data: data.map((e) => Recipe.fromJson(e)).toList());
    } else {
      return Error(
          message:
              "Error getting recipes - StatusCode: ${response.statusCode}");
    }
  }
}
