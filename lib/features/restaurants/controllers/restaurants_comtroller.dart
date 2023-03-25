import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaap_mobile_app/features/restaurants/models/cuisine_filter_model.dart';
import 'package:shaap_mobile_app/features/restaurants/repositories/restaurants_repository.dart';
import 'package:shaap_mobile_app/models/restaurant_model.dart';

//! the get all restaurants provider
final getAllRestaurantsProvider = FutureProvider<List<RestaurantModel>>((ref) {
  final restaurantController = ref.watch(restaurantControllerProvider.notifier);
  return restaurantController.getAllRestaurants();
});

//! the get filtered restaurants provider
final getFilteredRestaurantsProvider =
    FutureProvider.family<List<RestaurantModel>, CuisineFilterModel>(
        (ref, cuisineFilterModel) {
  final restaurantController = ref.watch(restaurantControllerProvider.notifier);
  return restaurantController.getFilteredRestaurants(
    name: cuisineFilterModel.name,
    cuisineids: cuisineFilterModel.cuisineIds,
    isOpen: cuisineFilterModel.isOpen,
    rating: cuisineFilterModel.rating,
  );
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

//! the restaurant controller
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

  //! filter restaurants
  Future<List<RestaurantModel>> getFilteredRestaurants({
    required String? name,
    required List<String> cuisineids,
    required String? isOpen,
    required String? rating,
  }) async {
    return _restaurantRepository.getFilteredRestaurants(
      name: name,
      cuisineids: cuisineids,
      isOpen: isOpen,
      rating: rating,
    );
  }
}


// //! the get all restaurants provider
// final getAllRestaurantsProvider = FutureProvider((ref) {
//   final restaurantController = ref.watch(restaurantControllerProvider.notifier);
//   return restaurantController.getAllRestaurants();
// });

// //! the get filtered restaurants provider
// final getFilteredProvider = FutureProvider.family((
//   ref,
//   String? name,
//   String? cuisineid1,
//   String? cuisineid2,
//   String? cuisineid3,
//   bool? isOpen,
//   String? rating,
// ) {
//   final restaurantController = ref.watch(restaurantControllerProvider.notifier);
//   return restaurantController.getFilteredRestaurants(
//       name: name,
//       cuisineid1: cuisineid1,
//       cuisineid2: cuisineid2,
//       cuisineid3: cuisineid3,
//       isOpen: isOpen,
//       rating: rating);
// });

// //! the restaurant controller provider
// final restaurantControllerProvider =
//     StateNotifierProvider<RestaurantController, bool>((ref) {
//   final restaurantRepository = ref.watch(restaurantRepositoryProvider);

//   return RestaurantController(
//     restaurantRepository: restaurantRepository,
//     ref: ref,
//   );
// });

// //! the restaurant controller
// class RestaurantController extends StateNotifier<bool> {
//   final RestaurantsRepository _restaurantRepository;
//   final Ref _ref;
//   RestaurantController({
//     required RestaurantsRepository restaurantRepository,
//     required Ref ref,
//   })  : _restaurantRepository = restaurantRepository,
//         _ref = ref,
//         super(false);

//   //! get all restaurants
//   Future<List<RestaurantModel>> getAllRestaurants() async {
//     return _restaurantRepository.getAllRestaurants();
//   }

//   //! filter restaurants
//   Future<List<RestaurantModel>> getFilteredRestaurants({
//     required String? name,
//     required String? cuisineid1,
//     required String? cuisineid2,
//     required String? cuisineid3,
//     required bool? isOpen,
//     required String? rating,
//   }) async {
//     return _restaurantRepository.getFilteredRestaurants(
//       name: name,
//       cuisineid1: cuisineid1,
//       cuisineid2: cuisineid2,
//       cuisineid3: cuisineid3,
//       isOpen: isOpen,
//       rating: rating,
//     );
//   }
// }
