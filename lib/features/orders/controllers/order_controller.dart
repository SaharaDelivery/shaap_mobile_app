import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaap_mobile_app/features/orders/repositories/order_repository.dart';
import 'package:shaap_mobile_app/models/order_model.dart';
import 'package:shaap_mobile_app/utils/shared_prefs.dart';
import 'package:shaap_mobile_app/utils/type_defs.dart';
import 'package:shaap_mobile_app/utils/utils.dart';

//! check If Order Exists In Restaurant provider
final checkIfOrderExistsInRestaurantProvider =
    FutureProvider.autoDispose.family((ref, String restaurantId) {
  final orderController = ref.watch(orderControllerProvider.notifier);
  return orderController.checkIfOrderExistsInRestaurant(
      restaurantId: restaurantId);
});

//! get order details provider
final getOrderDetailsProvider =
    FutureProvider.autoDispose.family((ref, String orderId) {
  final orderController = ref.watch(orderControllerProvider.notifier);
  return orderController.getOrderDetails(orderId: orderId);
});

final orderControllerProvider = StateNotifierProvider<OrderController, bool>(
  (ref) {
    final orderRepository = ref.watch(orderRepositoryProvider);
    final SharedPrefs sharedPrefs = SharedPrefs();
    return OrderController(
      orderRepository: orderRepository,
      sharedPrefs: sharedPrefs,
      ref: ref,
    );
  },
);

class OrderController extends StateNotifier<bool> {
  final OrderRepository _orderRepository;
  final SharedPrefs _sharedPrefs;
  final Ref _ref;
  OrderController({
    required OrderRepository orderRepository,
    required SharedPrefs sharedPrefs,
    required Ref ref,
  })  : _orderRepository = orderRepository,
        _sharedPrefs = sharedPrefs,
        _ref = ref,
        super(false);

  //! create an order
  void createAnOrder({
    required BuildContext context,
    required int restaurantId,
    required int menuItemId,
    required int quantity,
  }) async {
    state = true;
    final res = await _orderRepository.createOrderForARestaurant(
      restaurantId: restaurantId,
      menuItemId: menuItemId,
      quantity: quantity,
    );
    state = false;

    res.fold(
      (l) => showBanner(
        context: context,
        theMessage: l.message,
        theType: NotificationType.failure,
      ),
      (r) {
        log(r);
        showBanner(
          context: context,
          theMessage: r,
          theType: NotificationType.success,
        );
      },
    );
  }

  //! check if order exists in a restaurant
  Future<String> checkIfOrderExistsInRestaurant(
      {required String restaurantId}) async {
    return _orderRepository.checkIfOrderExistsInRestaurant(
        restaurantId: restaurantId);
  }

  //! get order details
  Future<OrderModel> getOrderDetails({
    required String orderId,
  }) async {
    return _orderRepository.getOrderDetails(orderId: orderId);
  }
}
