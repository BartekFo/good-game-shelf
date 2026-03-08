import 'package:dio/dio.dart';

import 'rawg_config.dart';

class ApiClient {
  ApiClient({Dio? dio}) : _dio = dio ?? Dio(_defaultOptions);

  final Dio _dio;

  static BaseOptions get _defaultOptions => BaseOptions(
    baseUrl: RawgConfig.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  );

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    if (RawgConfig.apiKey.trim().isEmpty) {
      throw StateError('Missing RAWG_API_KEY dart define.');
    }

    return _dio.get<dynamic>(
      path,
      queryParameters: <String, dynamic>{
        'key': RawgConfig.apiKey,
        ...?queryParameters,
      },
    );
  }
}
