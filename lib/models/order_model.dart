// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:shaap_mobile_app/models/order_item_model.dart';

class OrderModel {
  final String order_id;
  final Restaurant restaurant;
  final String status;
  final String total_price;
  final List<OrderItemModel> orderItem;
  final String date_created;
  const OrderModel({
    required this.order_id,
    required this.restaurant,
    required this.status,
    required this.total_price,
    required this.orderItem,
    required this.date_created,
  });

  OrderModel copyWith({
    String? order_id,
    Restaurant? restaurant,
    String? status,
    String? total_price,
    List<OrderItemModel>? orderItem,
    String? date_created,
  }) {
    return OrderModel(
      order_id: order_id ?? this.order_id,
      restaurant: restaurant ?? this.restaurant,
      status: status ?? this.status,
      total_price: total_price ?? this.total_price,
      orderItem: orderItem ?? this.orderItem,
      date_created: date_created ?? this.date_created,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order_id': order_id,
      'restaurant': restaurant.toMap(),
      'status': status,
      'total_price': total_price,
      'orderItem': orderItem.map((x) {return x.toMap();}).toList(growable: false),
      'date_created': date_created,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      order_id: (map["order_id"] ?? '') as String,
      restaurant: Restaurant.fromMap((map["restaurant"]?? Map<String,dynamic>.from({})) as Map<String,dynamic>),
      status: (map["status"] ?? '') as String,
      total_price: (map["total_price"] ?? '') as String,
      orderItem: List<OrderItemModel>.from(((map['orderItem'] ?? const <OrderItemModel>[]) as List).map<OrderItemModel>((x) {return OrderItemModel.fromMap((x?? Map<String,dynamic>.from({})) as Map<String,dynamic>);}),),
      date_created: (map["date_created"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(order_id: $order_id, restaurant: $restaurant, status: $status, total_price: $total_price, orderItem: $orderItem, date_created: $date_created)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.order_id == order_id &&
      other.restaurant == restaurant &&
      other.status == status &&
      other.total_price == total_price &&
      listEquals(other.orderItem, orderItem) &&
      other.date_created == date_created;
  }

  @override
  int get hashCode {
    return order_id.hashCode ^
      restaurant.hashCode ^
      status.hashCode ^
      total_price.hashCode ^
      orderItem.hashCode ^
      date_created.hashCode;
  }
}

// --- restaurant
class Restaurant {
  final int id;
  final String name;
  const Restaurant({
    required this.id,
    required this.name,
  });

  Restaurant copyWith({
    int? id,
    String? name,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: (map["id"] ?? 0) as int,
      name: (map["name"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(String source) =>
      Restaurant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Restaurant(id: $id, name: $name)';

  @override
  bool operator ==(covariant Restaurant other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
