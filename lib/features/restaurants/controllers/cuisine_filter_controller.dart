import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaap_mobile_app/features/restaurants/models/cuisine_filter_model.dart';

final cuisineFilterControllerProvider =
    StateNotifierProvider<CuisineFilterController, CuisineFilterModel>(
  (ref) => CuisineFilterController(),
);

class CuisineFilterController extends StateNotifier<CuisineFilterModel> {
  CuisineFilterController() : super(const CuisineFilterModel('', [], '0.0'));

  void updateFilter({
    String? name,
    List<String>? cuisineIds,
    String? rating,
  }) {
    state = state.copyWith(name: name, cuisineIds: cuisineIds, rating: rating);
  }
}
