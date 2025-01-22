import 'package:dio/dio.dart';

class UnplashApiService {
  final String _baseUrl = "https://api.unsplash.com";
  final String _accessKey = "3khKiJSBLCnqw3lQ4wcXQDE8MQ61GOYdBG2XvpL5L_Q";
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchPhotos({int page = 1, int perPage = 30}) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/photos',
        queryParameters: {
          'page': page,
          'per_page': perPage,
          'order_by': 'latest',
        },
        options: Options(
          headers: {
            'Authorization': 'Client-ID $_accessKey',
            'Accept-Version': 'v1',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to load photos: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load photos: $e');
    }
  }
}
