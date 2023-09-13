import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/src/models/api_response.dart';
import 'package:tech_task/src/models/ingredent.dart';
import 'package:tech_task/src/repository/launch_repo.dart';
import 'package:tech_task/src/repository/network_api.dart';

void main() {
  group("Lunch repo test - ", () {
    final repo = LaunchRepo(FakeNetworkApi());

    test('Fetch ingredients Test ...', () async {
      final response = await repo.getIngredents();
      // ignore: unnecessary_statements
      (switch (response) {
        Error() => print(response.message),
        Success() => print(response.data)
      });

      print(response);
      expect(response, isA<ApiResponse>());
      expect(response, isA<Success>());
      if (response is Success) {
        expect(response.data, isA<List<Ingredent>>());
      }
    });

    test('Fetch recipes test ...', () async {
      final response = await repo.getRecipes({"ingredients": "Cheese,Bread"});
      print(response);
      expect(response, isA<ApiResponse>());
      expect(response, isA<Success>());
    });
  });
}
