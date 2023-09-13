import 'package:dio/dio.dart';
import 'package:tech_task/src/contants/base_url.dart';

///Responsible for making http network requests
final class NetworkApi {
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
