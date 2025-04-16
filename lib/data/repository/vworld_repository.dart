import 'package:dio/dio.dart';

class VworldRepository {
  Future<List<String>> searchByLatLng(double lat, double lng) async {
    final Dio dio = Dio();
    try {
      final response = await dio.get(
        'https://api.vworld.kr/req/data',
        queryParameters: {
          'request': 'GetFeature',
          'key': 'A1C856D6-B867-3902-9E3B-63BA7E16FE64',
          'data': 'LT_C_ADEMD_INFO',
          'geomFilter': 'POINT($lat $lng)',
          'geometry': false,
        },
      );

      if (response.statusCode == 200 &&
          response.data['response']['status'] == 'OK') {
        return List.from(response.data['response']['result']['featureCollection']
                ['features'])
            .map((e) => e['properties']['full_nm'].toString())
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('vworld검색 오류: $e');
      return [];
    }
  }
}
