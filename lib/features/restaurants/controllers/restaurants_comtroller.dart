import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaap_mobile_app/features/restaurants/repositories/restaurants_repository.dart';
import 'package:shaap_mobile_app/models/restaurant_model.dart';

//! the get all restaurants provider
final getAllRestaurantsProvider = FutureProvider((ref) {
  final restaurantController = ref.watch(restaurantControllerProvider.notifier);
  return restaurantController.getAllRestaurants();
});

//! the restaurant controller provider
final restaurantControllerProvider =
    StateNotifierProvider<RestaurantController, bool>((ref) {
  final restaurantRepository = ref.watch(restaurantRepositoryProvider);

  return RestaurantController(
    restaurantRepository: restaurantRepository,
    ref: ref,
  );
});

class RestaurantController extends StateNotifier<bool> {
  final RestaurantsRepository _restaurantRepository;
  final Ref _ref;
  RestaurantController({
    required RestaurantsRepository restaurantRepository,
    required Ref ref,
  })  : _restaurantRepository = restaurantRepository,
        _ref = ref,
        super(false);

  //! get all restaurants
  Future<List<RestaurantModel>> getAllRestaurants() async {
    return _restaurantRepository.getAllRestaurants();
  }
}
