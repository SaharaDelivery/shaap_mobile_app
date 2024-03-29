// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderItemModel {
  final String orderId;
  final int cartItemId;
  final String name;
  final String price;
  final String imageUrl;
  final int quantity;
  const OrderItemModel({
    required this.orderId,
    required this.cartItemId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  OrderItemModel copyWith({
    String? orderId,
    int? cartItemId,
    String? name,
    String? price,
    String? imageUrl,
    int? quantity,
  }) {
    return OrderItemModel(
      orderId: orderId ?? this.orderId,
      cartItemId: cartItemId ?? this.cartItemId,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'cartItemId': cartItemId,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      orderId: (map["orderId"] ?? '') as String,
      cartItemId: (map["cartItemId"] ?? 0) as int,
      name: (map["name"] ?? '') as String,
      price: (map["price"] ?? '') as String,
      imageUrl: (map["imageUrl"] ?? '') as String,
      quantity: (map["quantity"] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItemModel.fromJson(String source) =>
      OrderItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderItemModel(orderId: $orderId, cartItemId: $cartItemId, name: $name, price: $price, imageUrl: $imageUrl, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant OrderItemModel other) {
    if (identical(this, other)) return true;

    return other.orderId == orderId &&
        other.cartItemId == cartItemId &&
        other.name == name &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        cartItemId.hashCode ^
        name.hashCode ^
        price.hashCode ^
        imageUrl.hashCode ^
        quantity.hashCode;
  }
}

// -------
class MenuItem {
  final String name;
  final String price;
  const MenuItem({
    required this.name,
    required this.price,
  });

  MenuItem copyWith({
    String? name,
    String? price,
  }) {
    return MenuItem(
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
    };
  }

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      name: (map["name"] ?? '') as String,
      price: (map["price"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuItem.fromJson(String source) =>
      MenuItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MenuItem(name: $name, price: $price)';

  @override
  bool operator ==(covariant MenuItem other) {
    if (identical(this, other)) return true;

    return other.name == name && other.price == price;
  }

  @override
  int get hashCode => name.hashCode ^ price.hashCode;
}
