// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CuisineModel {
  final String id;
  final String name;
  const CuisineModel({
    required this.id,
    required this.name,
  });

  CuisineModel copyWith({
    String? id,
    String? name,
  }) {
    return CuisineModel(
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

  factory CuisineModel.fromMap(Map<String, dynamic> map) {
    return CuisineModel(
      id: (map["id"] ?? '') as String,
      name: (map["name"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CuisineModel.fromJson(String source) => CuisineModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CuisineModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant CuisineModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
