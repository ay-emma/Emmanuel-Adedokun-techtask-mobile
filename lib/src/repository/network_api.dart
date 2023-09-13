import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:tech_task/src/contants/base_url.dart';

///Responsible for making http network requests
abstract class NetworkInterface {
  Future<Response> get(String path, [Map<String, dynamic>? queryParameters]);
}

class NetworkApi extends NetworkInterface {
  NetworkApi() {
    _dio = Dio(_options);
  }

  late final Dio _dio;

  static final Map<String, String> _requestHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  static final _options = BaseOptions(
    baseUrl: baseUrl,
    headers: _requestHeaders,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 5),
  );
  @override
  Future<Response> get(String path,
      [Map<String, dynamic>? queryParameters]) async {
    if (path.isEmpty) {
      throw FormatException('Invalid path');
    }
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}

//For mocking network calls using Mockito
class FakeNetworkApi extends Fake implements NetworkInterface {
  @override
  Future<Response> get(String path, [Map<String, dynamic>? queryParameters]) {
    if (path == "/ingredients") {
      return Future.value(
        Response(
          statusCode: 200,
          data: [
            {"title": "Ham", "use-by": "2020-11-25"},
            {"title": "Cheese", "use-by": "2020-01-08"},
            {"title": "Bread", "use-by": "2020-11-01"},
            {"title": "Beetroot", "use-by": "2019-11-06"},
            {"title": "Salad Dressing", "use-by": "2019-11-06"}
          ],
          requestOptions: RequestOptions(),
        ),
      );
    }
    if (path == '/recipes') {
      return Future.value(Response(
        statusCode: 200,
        data: [
          {
            "title": "Ham and Cheese Toastie",
            "ingredients": ["Ham", "Cheese", "Bread", "Butter"]
          },
          {
            "title": "Salad",
            "ingredients": [
              "Lettuce",
              "Tomato",
              "Cucumber",
              "Beetroot",
              "Salad Dressing"
            ]
          },
          {
            "title": "Hotdog",
            "ingredients": ["Hotdog Bun", "Sausage", "Ketchup", "Mustard"]
          }
        ],
        requestOptions: RequestOptions(),
      ));
    }
    throw UnimplementedError();
  }
}
