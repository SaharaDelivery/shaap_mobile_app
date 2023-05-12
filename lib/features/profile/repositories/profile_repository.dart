import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shaap_mobile_app/models/address_model.dart';
import 'package:shaap_mobile_app/shared/app_urls.dart';
import 'package:shaap_mobile_app/utils/failure.dart';
import 'package:shaap_mobile_app/utils/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:shaap_mobile_app/utils/type_defs.dart';

final profileRepositoryProvider = Provider(
  (ref) => ProfileRepository(
    sharedPrefs: SharedPrefs(),
  ),
);

class ProfileRepository {
  final SharedPrefs _sharedPrefs;
  ProfileRepository({
    required SharedPrefs sharedPrefs,
  }) : _sharedPrefs = sharedPrefs;

  //! add and save addresses
  FutureVoid addAndSaveAddress({
    required String address_1,
    required String address_2,
    required String phone_number,
    required String email,
  }) async {
    try {
      String? token = await _sharedPrefs.getString(key: 'x-auth-token');

      final body = {
        "address_1": address_1,
        "address_2": address_2,
        "phone_number": phone_number,
        "email": email,
        "saved": true,
      };

      final headers = {
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Token $token",
      };

      final response = await http.post(
        Uri.parse(AppUrls.createOrderAddress),
        headers: headers,
        body: jsonEncode(body),
      );

      log(response.statusCode.toString());

      // http.Request request =
      //     http.Request('POST', Uri.parse(AppUrls.createOrderAddress));

      // request.headers.addAll({
      //   "Content-Type": "application/json; charset=UTF-8",
      //   "Authorization": "Token $token",
      // });

      // request.body = jsonEncode({
      //   "address_1": address_1,
      //   "address_2": address_2,
      //   "phone_number": phone_number,
      //   "email": email,
      //   "saved": true,
      // });

      // http.StreamedResponse response = await request.send();

      // log(response.statusCode.toString());

      // String responseStream = await response.stream.bytesToString();

      // Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      if (response.statusCode == 201) {
        return right(null);
      } else {
        return left(Failure('error'));
      }
    } on SocketException catch (e) {
      log(e.toString());
      throw Exception('No internet connection');
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! add (choose to save or not) address
  FutureEither<AddressModel> addAndChooseAddress({
    required String address_1,
    required String address_2,
    required String phone_number,
    required String email,
    required bool saved,
  }) async {
    try {
      String? token = await _sharedPrefs.getString(key: 'x-auth-token');

      http.Request request =
          http.Request('POST', Uri.parse(AppUrls.createOrderAddress));

      request.headers.addAll({
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Token $token",
      });

      request.body = jsonEncode({
        "address_1": address_1,
        "address_2": address_2,
        "phone_number": phone_number,
        "email": email,
        "saved": false,
      });

      http.StreamedResponse response = await request.send();

      log(response.statusCode.toString());

      String responseStream = await response.stream.bytesToString();

      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      if (response.statusCode == 201) {
        AddressModel address = AddressModel.fromMap(responseInMap);
        return right(address);
      } else {
        return left(Failure('error'));
      }
    } on SocketException catch (e) {
      log(e.toString());
      throw Exception('No internet connection');
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //! get users saved address
  Future<List<AddressModel>> getUsersSavedAddress() async {
    try {
      String? token = await _sharedPrefs.getString(key: 'x-auth-token');
      final response = await http.get(
        Uri.parse(AppUrls.getSavedAddress),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Token $token",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData =
            json.decode(response.body) as List<dynamic>;
        final List<AddressModel> addresses = responseData
            .map((data) => AddressModel.fromMap(data as Map<String, dynamic>))
            .toList();
        return addresses;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } on SocketException catch (e) {
      log(e.toString());
      throw Exception('No internet connection');
    }
  }

  //! edit address
  FutureEither<AddressModel> editAddress({
    required String address_1,
    required String address_2,
    required String phone_number,
    required String email,
    required bool saved,
    required String addressId,
  }) async {
    try {
      String? token = await _sharedPrefs.getString(key: 'x-auth-token');

      http.Request request = http.Request(
          'PUT', Uri.parse(AppUrls.editAddress(addressId: addressId)));

      request.headers.addAll({
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Token $token",
      });

      request.body = jsonEncode({
        "address_1": address_1,
        "address_2": address_2,
        "phone_number": phone_number,
        "email": email,
        "saved": saved,
      });

      http.StreamedResponse response = await request.send();

      log(response.statusCode.toString());

      String responseStream = await response.stream.bytesToString();

      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      if (response.statusCode == 201) {
        AddressModel address = AddressModel.fromMap(responseInMap);
        return right(address);
      } else {
        return left(Failure('error'));
      }
    } on SocketException catch (e) {
      log(e.toString());
      throw Exception('No internet connection');
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
