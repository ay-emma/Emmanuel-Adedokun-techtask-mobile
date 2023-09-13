import 'package:tech_task/src/repository/network_api.dart';
import 'package:test/test.dart';

void main() {
  group('Network api test - ', () {
    late NetworkApi networkApi;
    setUp(() {
      networkApi = NetworkApi();
    });
    test("GET request", () async {
      final response = await networkApi.get("/ingredients");

      expect(response.statusCode, 200);
    });

    test("GET request with invalid path", () async {
      expect(() => networkApi.get(""), throwsA(isA<FormatException>()));

      //bad endpoint
      expect(() => networkApi.get("blabla"), throwsA(isA<Exception>()));
    });
  });
}
