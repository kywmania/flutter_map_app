import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map_app/data/model/location_model.dart';

class LocationRepository {
  Future<List<LocationModel>?> search(String query) async {
    final Dio _dio = Dio();
    final encodedQuery = Uri.encodeComponent(query);
    try {
      final response = await _dio.get(
        'https://openapi.naver.com/v1/search/local.json',
        queryParameters: {
          'query': encodedQuery,
          'display': 5,
        },
        options: Options(
          headers: {
            'X-Naver-Client-Id': dotenv.env['NAVER_CLIENT_ID'] ?? '',
            'X-Naver-Client-Secret': dotenv.env['NAVER_CLIENT_SECRET'] ?? '',
          },
        ),
      );

      if (response.statusCode == 200) {
        final map = response.data;
        return List.from(map["items"])
            .map((e) => LocationModel.fromJson(e))
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      print('검색 오류: $e');
      return null;
    }
  }
}
