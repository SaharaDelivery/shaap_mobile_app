// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:shaap_mobile_app/models/food_model.dart';

class MenuModel {
  final List<FoodModel?> mainCourses;
  final List<FoodModel?> sideDishes;
  final List<FoodModel?> wraps;
  const MenuModel({
    required this.mainCourses,
    required this.sideDishes,
    required this.wraps,
  });

  MenuModel copyWith({
    List<FoodModel?>? mainCourses,
    List<FoodModel?>? sideDishes,
    List<FoodModel?>? wraps,
  }) {
    return MenuModel(
      mainCourses: mainCourses ?? this.mainCourses,
      sideDishes: sideDishes ?? this.sideDishes,
      wraps: wraps ?? this.wraps,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mainCourses': mainCourses.map((x) {return x?.toMap();}).toList(growable: false),
      'sideDishes': sideDishes.map((x) {return x?.toMap();}).toList(growable: false),
      'wraps': wraps.map((x) {return x?.toMap();}).toList(growable: false),
    };
  }

  factory MenuModel.fromMap(Map<String, dynamic> map) {
    return MenuModel(
      mainCourses: List<FoodModel?>.from(((map['mainCourses'] ?? const <FoodModel?>[]) as List).map<FoodModel?>((x) {return FoodModel.fromMap((x?? Map<String,dynamic>.from({})) as Map<String,dynamic>);}),),
      sideDishes: List<FoodModel?>.from(((map['sideDishes'] ?? const <FoodModel?>[]) as List).map<FoodModel?>((x) {return FoodModel.fromMap((x?? Map<String,dynamic>.from({})) as Map<String,dynamic>);}),),
      wraps: List<FoodModel?>.from(((map['wraps'] ?? const <FoodModel?>[]) as List).map<FoodModel?>((x) {return FoodModel.fromMap((x?? Map<String,dynamic>.from({})) as Map<String,dynamic>);}),),
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuModel.fromJson(String source) => MenuModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MenuModel(mainCourses: $mainCourses, sideDishes: $sideDishes, wraps: $wraps)';

  @override
  bool operator ==(covariant MenuModel other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.mainCourses, mainCourses) &&
      listEquals(other.sideDishes, sideDishes) &&
      listEquals(other.wraps, wraps);
  }

  @override
  int get hashCode => mainCourses.hashCode ^ sideDishes.hashCode ^ wraps.hashCode;
}
