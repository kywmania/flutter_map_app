import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map_app/data/model/location_model.dart';
import 'package:http/http.dart';

class LocationRepository {
  Future<List<LocationModel>?> search(String query) async {
    await dotenv.load();

    try {
      Client client = Client();
      Response response = await client.get(
          Uri.parse(
              'https://openapi.naver.com/v1/search/blog.json?query=$query'),
          headers: {
            // Id, Secret .env파일에서 불러오기
            'X-Naver-Client-Id': dotenv.env['NAVER_CLIENT_ID'] ?? '',
            'X-Naver-Client-Secret': dotenv.env['NAVER_CLIENT_SECRET'] ?? '',
          });

      if (response.statusCode == 200) {
        final map = jsonDecode(response.body);
        return List.from(map["items"])
            .map((e) => LocationModel.fromJson(e))
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
