import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:shaap_mobile_app/shared/app_urls.dart';
import 'package:shaap_mobile_app/utils/failure.dart';
import 'package:shaap_mobile_app/utils/shared_prefs.dart';
import 'package:shaap_mobile_app/utils/type_defs.dart';
import 'package:shaap_mobile_app/models/user_model.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    sharedPrefs: SharedPrefs(),
  ),
);

class AuthRepository {
  final SharedPrefs _sharedPrefs;
  AuthRepository({
    required SharedPrefs sharedPrefs,
  }) : _sharedPrefs = sharedPrefs;

  //! sign up
  FutureEither<String> signUpUser({
    required String email,
    required String password,
  }) async {
    try {
      UserModel userModel = const UserModel(
        email: '',
        firstName: '',
        lastName: '',
        userName: '',
        phoneNumber: '',
        profilePic: '',
        uid: '',
        token: '',
      );

      late UserModel newUser;

      late String message;

      final body = {
        "password": password,
        "email": email,
      };

      final response =
          await http.post(Uri.parse(AppUrls.userSignUp), body: body);

      // http.Request request =
      //     http.Request('POST', Uri.parse(AppUrls.userSignUp));

      // request.headers
      //     .addAll({"Content-Type": "application/json; charset=UTF-8"});

      // //! request body
      // request.body = jsonEncode({
      //   "password": password,
      //   "email": email,
      // });

      // http.StreamedResponse response = await request.send();

      // String responseStream = await response.stream.bytesToString();

      // Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      if (response.statusCode == 201) {
        message = 'success';
        _sharedPrefs.setString(
          key: 'id',
          stringToStore: response.body.toString(),
        );
        // newUser = UserModel(
        //   email: email,
        //   firstName: '',
        //   lastName: '',
        //   userName: '',
        //   phoneNumber: '',
        //   profilePic: '',
        //   uid: response.body,
        //   token: '',
        // );
      } else {
        message = response.reasonPhrase!;
      }
      log(response.body);
      return right(message);
    } catch (e) {
      log(e.toString());
      return left(Failure(e.toString()));
    }
  }

  // details
  FutureEither<String> setupProfileDetails({
    required String id,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String userName,
  }) async {
    try {
      late String message;

      final body = {
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "user_name": userName,
      };

      final response =
          await http.put(Uri.parse(AppUrls.profileDetails(id: id)), body: body);

      if (response.statusCode == 200) {
        message = 'success';
        // newUser = UserModel(
        //   email: email,
        //   firstName: '',
        //   lastName: '',
        //   userName: '',
        //   phoneNumber: '',
        //   profilePic: '',
        //   uid: response.body,
        //   token: '',
        // );
      } else {
        message = response.reasonPhrase!;
      }
      log(response.body);
      return right(message);
    } catch (e) {
      log(e.toString());
      return left(Failure(e.toString()));
    }
  }

  //! log in
  FutureEither<UserModel> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserModel userModel = const UserModel(
        email: '',
        firstName: '',
        lastName: '',
        userName: '',
        phoneNumber: '',
        profilePic: '',
        uid: '',
        token: '',
      );

      late UserModel newUser;

      http.Request request = http.Request('POST', Uri.parse(AppUrls.userLogin));

      request.headers
          .addAll({"Content-Type": "application/json; charset=UTF-8"});

      //! request body
      request.body = jsonEncode({
        "password": password,
        "email": email,
      });

      http.StreamedResponse response = await request.send();

      String responseStream = await response.stream.bytesToString();

      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      if (response.statusCode == 200) {
        _sharedPrefs.setString(
            key: 'x-auth-token', stringToStore: responseInMap['token']);
        newUser = userModel.copyWith(
          uid: responseInMap['user']['id'].toString(),
          firstName: responseInMap['user']['first_name'],
          lastName: responseInMap['user']['last_name'],
          phoneNumber: responseInMap['user']['phone_number'],
          email: responseInMap['user']['email'],
        );
      } else {}

      final String token =
          await SharedPrefs().getString(key: 'x-auth-token') ?? '';
      
      log(token);
      log(responseInMap['token'].toString());
      return right(newUser);
    } catch (e) {
      log(e.toString());
      return left(Failure(e.toString()));
    }
  }
}
