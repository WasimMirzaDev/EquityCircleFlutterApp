import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "${dotenv.env['API_URL']!}/api",
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    ),
  );

  static Future<Response> getRequest(String endpoint, [String? token]) async {
    try {
      Response response = await _dio.get(
        endpoint,
        options: Options(
          headers: token == null ? null : {'Authorization': 'Bearer $token'},
        ),
      );
      return response;
    } catch (e) {
      throw Exception("Failed to fetch data");
    }
  }

  static Future<Response> postRequest(
    String endpoint,
    dynamic data, [
    String? token,
  ]) async {
    try {
      Response response = await _dio.post(
        endpoint,
        options: Options(
          contentType:
              data is FormData ? "multipart/form-data" : "application/json",
          headers: token == null ? null : {'Authorization': 'Bearer $token'},
        ),
        data: data,
      );
      print("Response $response");
      return response;
    } catch (e) {
      throw Exception("Failed to post data $e");
    }
  }
}
