import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeState {
  final String? title;
  final String? category;
  final String? roadAddress;

  HomeState({
    required this.title,
    required this.category,
    required this.roadAddress,
  });
}

class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    return state = HomeState(
      title: null,
      category: null,
      roadAddress: null,
    );
  }
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(() {
  return HomeViewModel();
});
