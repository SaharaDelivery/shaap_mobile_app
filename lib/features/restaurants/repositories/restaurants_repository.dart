import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaap_mobile_app/models/cuisine_model.dart';
import 'package:shaap_mobile_app/models/restaurant_model.dart';
import 'package:http/http.dart' as http;
import 'package:shaap_mobile_app/shared/app_urls.dart';

final restaurantRepositoryProvider = Provider((ref) {
  return RestaurantsRepository();
});

class RestaurantsRepository {
  // get all restaurants
  Future<List<RestaurantModel>> getAllRestaurants() async {
    try {
      //
      http.Response response =
          await http.get(Uri.parse(AppUrls.getAllRestaurants));
      if (response.statusCode == 200) {
        final List<dynamic> resultRestaurants = jsonDecode(response.body);
        final List<dynamic> resultCuisine = resultRestaurants[0]['cuisine'];
        // log(resultRestaurants.toString());
        List<RestaurantModel> restaurants = resultRestaurants.map((e) {
          final List<CuisineModel> cuisines = resultCuisine
              .map((c) => CuisineModel(
                    id: c['id'],
                    name: c['name'],
                  ))
              .toList();
          return RestaurantModel(
            id: e['id'],
            cover_photo: e['cover_photo'],
            name: e['name'],
            cuisine: cuisines,
            description: e['description'],
            opening_time: e['opening_time'],
            closing_time: e['closing_time'],
            rating: e['rating'],
          );
        }).toList();

        return restaurants;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } on SocketException catch (e) {
      log(e.toString());
      throw Exception('No internet connection');
    }
  }

  //! get filtered restaurants
  Future<List<RestaurantModel>> getFilteredRestaurants({
    required String? name,
    required List<String> cuisineids,
    required String? isOpen,
    required String? rating,
  }) async {
    try {
      final queryParameters = {
        'name': name ?? '',
        if (cuisineids.isNotEmpty) 'cuisine': cuisineids.join(','),
        'is_open': isOpen ?? '',
        'rating': rating ?? '',
      };
      final uri =
          Uri.https('api.shaap.io', '/restaurant/filter/', queryParameters);
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> resultRestaurants = jsonDecode(response.body);
        final List<dynamic> resultCuisine = resultRestaurants[0]['cuisine'];
        log('list dey!');
        log(resultRestaurants.toString());
        List<RestaurantModel> restaurants = resultRestaurants.map((e) {
          final List<CuisineModel> cuisines = resultCuisine
              .map((c) => CuisineModel(
                    id: c['id'],
                    name: c['name'],
                  ))
              .toList();
          return RestaurantModel(
            id: e['id'],
            cover_photo: e['cover_photo'],
            name: e['name'],
            cuisine: cuisines,
            description: e['description'],
            opening_time: e['opening_time'],
            closing_time: e['closing_time'],
            rating: e['rating'],
          );
        }).toList();

        return restaurants;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } on SocketException catch (e) {
      log(e.toString());
      throw Exception('No internet connection');
    }
  }
}
