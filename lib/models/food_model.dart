// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FoodModel {
  final int id;
  final String image;
  final String name;
  final String description;
  final String menu;
  final String price;
  const FoodModel({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.menu,
    required this.price,
  });


  FoodModel copyWith({
    int? id,
    String? image,
    String? name,
    String? description,
    String? menu,
    String? price,
  }) {
    return FoodModel(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      description: description ?? this.description,
      menu: menu ?? this.menu,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'name': name,
      'description': description,
      'menu': menu,
      'price': price,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: (map["id"] ?? 0) as int,
      image: (map["image"] ?? '') as String,
      name: (map["name"] ?? '') as String,
      description: (map["description"] ?? '') as String,
      menu: (map["menu"] ?? '') as String,
      price: (map["price"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodModel.fromJson(String source) => FoodModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FoodModel(id: $id, image: $image, name: $name, description: $description, menu: $menu, price: $price)';
  }

  @override
  bool operator ==(covariant FoodModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.image == image &&
      other.name == name &&
      other.description == description &&
      other.menu == menu &&
      other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      image.hashCode ^
      name.hashCode ^
      description.hashCode ^
      menu.hashCode ^
      price.hashCode;
  }
}
