// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:shaap_mobile_app/models/cuisine_model.dart';

class RestaurantModel {
  final int id;
  final String cover_photo;
  final String name;
  final List<CuisineModel> cuisine;
  final String description;
  final String opening_time;
  final String closing_time;
  final String rating;
  const RestaurantModel({
    required this.id,
    required this.cover_photo,
    required this.name,
    required this.cuisine,
    required this.description,
    required this.opening_time,
    required this.closing_time,
    required this.rating,
  });

  RestaurantModel copyWith({
    int? id,
    String? cover_photo,
    String? name,
    List<CuisineModel>? cuisine,
    String? description,
    String? opening_time,
    String? closing_time,
    String? rating,
  }) {
    return RestaurantModel(
      id: id ?? this.id,
      cover_photo: cover_photo ?? this.cover_photo,
      name: name ?? this.name,
      cuisine: cuisine ?? this.cuisine,
      description: description ?? this.description,
      opening_time: opening_time ?? this.opening_time,
      closing_time: closing_time ?? this.closing_time,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cover_photo': cover_photo,
      'name': name,
      'cuisine': cuisine.map((x) {
        return x.toMap();
      }).toList(growable: false),
      'description': description,
      'opening_time': opening_time,
      'closing_time': closing_time,
      'rating': rating,
    };
  }

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      id: (map["id"] ?? '') as int,
      cover_photo: (map["cover_photo"] ?? '') as String,
      name: (map["name"] ?? '') as String,
      cuisine: List<CuisineModel>.from(
        ((map['cuisine'] ?? const <CuisineModel>[]) as List)
            .map<CuisineModel>((x) {
          return CuisineModel.fromMap(
              (x ?? Map<String, dynamic>.from({})) as Map<String, dynamic>);
        }),
      ),
      description: (map["description"] ?? '') as String,
      opening_time: (map["opening_time"] ?? '') as String,
      closing_time: (map["closing_time"] ?? '') as String,
      rating: (map["rating"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantModel.fromJson(String source) =>
      RestaurantModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RestaurantModel(id: $id, cover_photo: $cover_photo, name: $name, cuisine: $cuisine, description: $description, opening_time: $opening_time, closing_time: $closing_time, rating: $rating)';
  }

  @override
  bool operator ==(covariant RestaurantModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.cover_photo == cover_photo &&
        other.name == name &&
        listEquals(other.cuisine, cuisine) &&
        other.description == description &&
        other.opening_time == opening_time &&
        other.closing_time == closing_time &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        cover_photo.hashCode ^
        name.hashCode ^
        cuisine.hashCode ^
        description.hashCode ^
        opening_time.hashCode ^
        closing_time.hashCode ^
        rating.hashCode;
  }
}
