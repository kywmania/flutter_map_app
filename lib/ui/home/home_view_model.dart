import 'package:flutter_map_app/data/model/location_model.dart';
import 'package:flutter_map_app/data/repository/location_repository.dart';
import 'package:flutter_map_app/data/repository/vworld_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeState {
  List<LocationModel>? locations;
  HomeState({
    required this.locations,
  });
}

class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    return state = HomeState(
      locations: null,
    );
  }

  Future<void> search(String query) async {
    print('검색어 : $query');
    LocationRepository locationRepository = LocationRepository();
    state = HomeState(locations: await locationRepository.search(query));
  }

  Future<void> searchByLatLng(double lat, double lng) async{
    VworldRepository vworldRepository = VworldRepository();
    // 126.7764403, 37.50807  [경기도 부천시 원미구 중동]
    // 0 0 []
    final result = await vworldRepository.searchByLatLng(lat, lng);
    // result가 빈값이 아닐때 search()
    if(result.isNotEmpty){
      search(result[0]);
    }

  }
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(() {
  return HomeViewModel();
});
