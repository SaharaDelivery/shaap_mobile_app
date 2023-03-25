// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CuisineFilterModel {
  final String? name;
  // final String? cuisineid1;
  // final String? cuisineid2;
  // final String? cuisineid3;
  final List<String> cuisineIds;
  final String? isOpen;
  final String? rating;

  const CuisineFilterModel(
    this.name,
    this.cuisineIds,
    this.isOpen,
    this.rating,
  );

  CuisineFilterModel copyWith({
    String? name,
    List<String>? cuisineIds,
    String? isOpen,
    String? rating,
  }) {
    return CuisineFilterModel(
      name ?? this.name,
      cuisineIds ?? this.cuisineIds,
      isOpen ?? this.isOpen,
      rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cuisineIds': cuisineIds,
      'isOpen': isOpen,
      'rating': rating,
    };
  }

  factory CuisineFilterModel.fromMap(Map<String, dynamic> map) {
    return CuisineFilterModel(
      map['name'] != null ? map["name"] : null,
      List<String>.from(
        ((map['cuisineIds'] ?? const <String>[]) as List<String>),
      ),
      map['isOpen'] != null ? map["isOpen"] : null,
      map['rating'] != null ? map["rating"] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CuisineFilterModel.fromJson(String source) =>
      CuisineFilterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CuisineFilterModel(name: $name, cuisineIds: $cuisineIds, isOpen: $isOpen, rating: $rating)';
  }

  @override
  bool operator ==(covariant CuisineFilterModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        listEquals(other.cuisineIds, cuisineIds) &&
        other.isOpen == isOpen &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        cuisineIds.hashCode ^
        isOpen.hashCode ^
        rating.hashCode;
  }
}
