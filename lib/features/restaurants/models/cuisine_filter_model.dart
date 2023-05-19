// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CuisineFilterModel {
  final String? name;
  final List<String> cuisineIds;
  // final String? isOpen;
  final String? rating;

  const CuisineFilterModel(
    this.name,
    this.cuisineIds,
    this.rating,
  );

  CuisineFilterModel copyWith({
    String? name,
    List<String>? cuisineIds,
    String? rating,
  }) {
    return CuisineFilterModel(
      name ?? this.name,
      cuisineIds ?? this.cuisineIds,
      rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cuisineIds': cuisineIds,
      'rating': rating,
    };
  }

  factory CuisineFilterModel.fromMap(Map<String, dynamic> map) {
    return CuisineFilterModel(
      map['name'] != null ? map["name"] : null,
      List<String>.from(
        ((map['cuisineIds'] ?? const <String>[]) as List<String>),
      ),
      map['rating'] != null ? map["rating"] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CuisineFilterModel.fromJson(String source) =>
      CuisineFilterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CuisineFilterModel(name: $name, cuisineIds: $cuisineIds, rating: $rating)';

  @override
  bool operator ==(covariant CuisineFilterModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        listEquals(other.cuisineIds, cuisineIds) &&
        other.rating == rating;
  }

  @override
  int get hashCode => name.hashCode ^ cuisineIds.hashCode ^ rating.hashCode;
}
