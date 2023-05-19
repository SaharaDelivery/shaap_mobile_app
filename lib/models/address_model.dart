// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddressModel {
  final int id;
  final String address_1;
  final String address_2;
  final String phone_number;
  final String email;
  final bool saved;
  const AddressModel({
    required this.id,
    required this.address_1,
    required this.address_2,
    required this.phone_number,
    required this.email,
    required this.saved,
  });

  AddressModel copyWith({
    int? id,
    String? address_1,
    String? address_2,
    String? phone_number,
    String? email,
    bool? saved,
  }) {
    return AddressModel(
      id: id ?? this.id,
      address_1: address_1 ?? this.address_1,
      address_2: address_2 ?? this.address_2,
      phone_number: phone_number ?? this.phone_number,
      email: email ?? this.email,
      saved: saved ?? this.saved,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address_1': address_1,
      'address_2': address_2,
      'phone_number': phone_number,
      'email': email,
      'saved': saved,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: (map["id"] ?? 0) as int,
      address_1: (map["address_1"] ?? '') as String,
      address_2: (map["address_2"] ?? '') as String,
      phone_number: (map["phone_number"] ?? '') as String,
      email: (map["email"] ?? '') as String,
      saved: (map["saved"] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddressModel(id: $id, address_1: $address_1, address_2: $address_2, phone_number: $phone_number, email: $email, saved: $saved)';
  }

  @override
  bool operator ==(covariant AddressModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.address_1 == address_1 &&
        other.address_2 == address_2 &&
        other.phone_number == phone_number &&
        other.email == email &&
        other.saved == saved;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        address_1.hashCode ^
        address_2.hashCode ^
        phone_number.hashCode ^
        email.hashCode ^
        saved.hashCode;
  }
}
