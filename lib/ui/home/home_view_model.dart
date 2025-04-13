import 'package:flutter_map_app/data/model/location_model.dart';
import 'package:flutter_map_app/data/repository/location_repository.dart';
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
    LocationRepository locationRepository = LocationRepository();
    state = HomeState(locations: await locationRepository.search(query));
  }
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(() {
  return HomeViewModel();
});
