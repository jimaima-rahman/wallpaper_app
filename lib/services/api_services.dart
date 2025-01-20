// import 'package:dio/dio.dart';

// class PexelsApiService {
//   final String _baseUrl = "https://api.unsplash.com";
//   final String _accessKey = "3khKiJSBLCnqw3lQ4wcXQDE8MQ61GOYdBG2XvpL5L_Q";

//   final Dio _dio = Dio();

//   Future<List<dynamic>> listCollections(
//       {int page = 1, int perPage = 10}) async {
//     try {
//       final response = await _dio.get(
//         '$_baseUrl/collections',
//         queryParameters: {
//           'page': page,
//           'per_page': perPage,
//         },
//         options: Options(
//           headers: {
//             'Authorization': 'Client-ID $_accessKey',
//           },
//         ),
//       );

//       if (response.statusCode == 200) {
//         return response.data; // Returns a list of collections
//       } else {
//         throw Exception('Failed to load collections: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching collections: $e');
//       throw Exception('Error fetching collections');
//     }
//   }
// }

// lib/services/unsplash_api_service.dart
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
