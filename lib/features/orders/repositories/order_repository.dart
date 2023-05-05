import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shaap_mobile_app/models/order_item_model.dart';
import 'package:shaap_mobile_app/models/order_model.dart';
import 'package:shaap_mobile_app/shared/app_urls.dart';
import 'package:shaap_mobile_app/utils/failure.dart';
import 'package:shaap_mobile_app/utils/shared_prefs.dart';
import 'package:shaap_mobile_app/utils/type_defs.dart';
import 'package:http/http.dart' as http;

final orderRepositoryProvider = Provider(
  (ref) => OrderRepository(
    sharedPrefs: SharedPrefs(),
  ),
);

class OrderRepository {
  final SharedPrefs _sharedPrefs;
  OrderRepository({
    required SharedPrefs sharedPrefs,
  }) : _sharedPrefs = sharedPrefs;

  //! place an order
  FutureEither<String> createOrderForARestaurant({
    required int restaurantId,
    required int menuItemId,
    required int quantity,
  }) async {
    try {
      late String orderId;

      String? token = await _sharedPrefs.getString(key: 'x-auth-token');

      http.Request request =
          http.Request('POST', Uri.parse(AppUrls.createAnOrder));

      request.headers.addAll({
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Token $token",
      });

      request.body = jsonEncode({
        "restaurant": restaurantId,
        "menu_item": menuItemId,
        "quantity": quantity,
      });

      http.StreamedResponse response = await request.send();

      String responseStream = await response.stream.bytesToString();

      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      if (response.statusCode == 201) {
        orderId = responseInMap['order_id'];
      } else {
        return left(Failure('error'));
      }

      return right(orderId);
    } on SocketException catch (e) {
      log(e.toString());
      throw Exception('No internet connection');
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! check if order exists in a restaurant
  Future<String> checkIfOrderExistsInRestaurant(
      {required String restaurantId}) async {
    try {
      String? res;
      String? token = await _sharedPrefs.getString(key: 'x-auth-token');

      http.Response response = await http.get(
          Uri.parse(
            AppUrls.checkIfOrderExistsInRestaurant(restaurantId: restaurantId),
          ),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Token $token",
          });

      switch (response.statusCode) {
        case 200:
          final responseString = jsonDecode(response.body);
          res = responseString['order_id'];
          break;
        case 404:
          res = 'notfound';
          break;
        default:
          res = 'notfound';
      }
      log(response.statusCode.toString());
      log(res!);

      return res;
    } on SocketException catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  //! get order details
  Future<OrderModel> getOrderDetails({
    required String orderId,
  }) async {
    try {
      OrderModel orderModel;

      String? token = await _sharedPrefs.getString(key: 'x-auth-token');

      http.Response response = await http.get(
          Uri.parse(
            AppUrls.getOrderDetails(orderId: orderId),
          ),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Token $token",
          });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> orderItemsResultList = responseData['order_items'];
        final List<OrderItemModel> orderItems = orderItemsResultList
            .map((item) => OrderItemModel(
                  name: item['menu_item']['name'],
                  price: item['menu_item']['price'],
                  imageUrl: item['menu_item']['image'],
                  quantity: item['quantity'],
                ))
            .toList();

        orderModel = OrderModel(
          order_id: responseData['order_id'],
          restaurant: Restaurant(
            id: responseData['restaurant']['id'],
            name: responseData['restaurant']['name'],
          ),
          status: responseData['status'],
          total_price: responseData['total_price'],
          orderItem: orderItems,
          date_created: responseData['date_created'],
        );

        return orderModel;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } on SocketException catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  //! get order history
  Future<List<OrderModel>> getOrderHistory() async {
    try {
      String? token = await _sharedPrefs.getString(key: 'x-auth-token');

      http.Response response = await http.get(
          Uri.parse(
            AppUrls.getOrderHistory,
          ),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Token $token",
          });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        final List<dynamic> orderItemsResultList =
            responseData[0]['order_items'];

        List<OrderModel> orders = responseData.map(
          (e) {
            final List<OrderItemModel> orderItems = orderItemsResultList
                .map((item) => OrderItemModel(
                      name: item['menu_item']['name'],
                      price: item['menu_item']['price'],
                      imageUrl: '',
                      quantity: item['quantity'],
                    ))
                .toList();
            return OrderModel(
              order_id: e['order_id'],
              restaurant: Restaurant(
                id: e['restaurant']['id'],
                name: e['restaurant']['name'],
              ),
              status: '',
              total_price: e['total_price'],
              orderItem: orderItems,
              date_created: e['date_created'],
            );
          },
        ).toList();

        return orders;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } on SocketException catch (e) {
      log(e.toString());
      throw Exception('No internet connection');
    }
  }

  //! increase item in cart/ add item to existing cart
  FutureVoid increaseItemInCartAddItemToExistingCart({
    required String orderId,
    required int menuItemId,
    required int quantity,
  }) async {
    try {
      String? token = await _sharedPrefs.getString(key: 'x-auth-token');

      http.Request request =
          http.Request('POST', Uri.parse(AppUrls.increaseCartItemQuantityAddItemsToCart));

      request.headers.addAll({
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Token $token",
      });

      request.body = jsonEncode({
        "order": orderId,
        "menu_item": menuItemId,
        "quantity": quantity,
      });

      http.StreamedResponse response = await request.send();

      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        return right(null);
      } else {
        return left(Failure('error'));
      }
    } on SocketException catch (e) {
      log(e.toString());
      throw Exception('No internet connection');
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! get all cart items
  Future<List<OrderItemModel>> getAllCartItems({
    required String orderId,
  }) async {
    try {
      String? token = await _sharedPrefs.getString(key: 'x-auth-token');

      http.Response response = await http.get(
          Uri.parse(
            AppUrls.getAllCartItems(orderId: orderId),
          ),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Token $token",
          });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<OrderItemModel> orderItems = responseData
            .map((item) => OrderItemModel(
                  cartItemId: item['id'],
                  name: item['menu_item']['name'],
                  price: item['menu_item']['price'],
                  // imageUrl: item['menu_item']['image'],
                  imageUrl: '',
                  quantity: item['quantity'],
                ))
            .toList();

        return orderItems;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } on SocketException catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  //! remove item from cart
  FutureVoid removeItemFromCart({
    required String cartItemId,
  }) async {
    try {
      String? token = await _sharedPrefs.getString(key: 'x-auth-token');

      http.Response response = await http.delete(
          Uri.parse(
            AppUrls.removeItemFromCart(cartItemId: cartItemId),
          ),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Token $token",
          });

      if (response.statusCode == 200) {
        return right(null);
      } else {
        return left(Failure('error'));
      }
    } on SocketException catch (e) {
      log(e.toString());
      throw Exception('No internet connection');
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // reduce item in cart
  FutureVoid reduceItemInCart({
    required String cartItemId,
  }) async {
    try {
      String? token = await _sharedPrefs.getString(key: 'x-auth-token');

      http.Response response = await http.delete(
          Uri.parse(
            AppUrls.reduceItemFromCart(cartItemId: cartItemId),
          ),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Token $token",
          });

      log(response.reasonPhrase.toString());

      if (response.statusCode == 200) {
        return right(null);
      } else {
        return left(Failure('error'));
      }
    } on SocketException catch (e) {
      log(e.toString());
      throw Exception('No internet connection');
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
