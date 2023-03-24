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
      http.Response response =
          await http.get(Uri.parse(AppUrls.getAllRestaurants));
      if (response.statusCode == 200) {
        final List<dynamic> resultRestaurants = jsonDecode(response.body);
        final List<dynamic> resultCuisine = resultRestaurants[0]['cuisine'];
        log(resultRestaurants.toString());
        return resultRestaurants.map((e) {
          final List<CuisineModel> cuisines = resultCuisine
              .map((c) => CuisineModel(
                    id: c['id'].toString(),
                    name: c['name'],
                  ))
              .toList();
          return RestaurantModel(
            id: e['id'].toString(),
            cover_photo: e['cover_photo'],
            name: e['name'],
            cuisine: cuisines,
            description: e['description'],
            opening_time: e['opening_time'],
            closing_time: e['closing_time'],
            rating: e['rating'],
          );
        }).toList();
      } else {
        throw Exception(response.reasonPhrase);
      }
    } on SocketException catch (e) {
      log(e.toString());
      throw Exception('No internet connection');
    }
  }

  // Map<String, List<CuisineModel>> _createCuisineMap(List resultRestaurants) {
  //   final cuisineMap = Map<String, List<CuisineModel>>();
  //   for (final restaurant in resultRestaurants) {
  //     final List cuisines = restaurant['cuisine'];
  //     for (final cuisine in cuisines) {
  //       final id = cuisine['id'].toString();
  //       final name = cuisine['name'];
  //       if (!cuisineMap.containsKey(id)) {
  //         cuisineMap[id] = [];
  //       }
  //       cuisineMap[id]!.add(CuisineModel(id: id, name: name));
  //     }
  //   }
  //   return cuisineMap;
  // }
// In the getAllRestaurants() method, I first created a map of cuisines using the _createCuisineMap() method. The _createCuisineMap() method iterates over all restaurants and their cuisines and creates a map with cuisine IDs as keys and lists of CuisineModel objects as values.
// I can then use this map in the map() function to pass the appropriate list of cuisines to each RestaurantModel object.
}
