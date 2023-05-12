import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaap_mobile_app/features/auth/models/request_model.dart';
import 'package:shaap_mobile_app/features/auth/repositories/auth_repository.dart';
import 'package:shaap_mobile_app/features/auth/views/login_view.dart';
import 'package:shaap_mobile_app/features/auth/views/profile_details_form.dart';
import 'package:shaap_mobile_app/features/base_nav_wrapper/views/base_nav_wrapper.dart';
import 'package:shaap_mobile_app/features/onboarding/views/onboarding_view.dart';
import 'package:shaap_mobile_app/main.dart';
import 'package:shaap_mobile_app/models/user_model.dart';
import 'package:shaap_mobile_app/utils/failure.dart';
import 'package:shaap_mobile_app/utils/shared_prefs.dart';
import 'package:shaap_mobile_app/utils/type_defs.dart';
import 'package:shaap_mobile_app/utils/utils.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthController(authRepository: authRepository, ref: ref);
  },
);

// final signUpUserProvider = FutureProvider.autoDispose<void>((ref) async {
//   final controller = ref.read(authControllerProvider.notifier);
//   final context =
//       ref.watch(navigatorKeyProvider).currentState!.overlay!.context;
//   String email = '';
//   String password = '';
//   await controller.signUpUser(
//       context: context, email: email, password: password);
// });

// elsewhere in your code
// final emailInputProvider = StateProvider<String>((ref) => '');
// final passwordInputProvider = StateProvider<String>((ref) => '');

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

//! sign up
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = true;
    final response =
        await _authRepository.signUpUser(email: email, password: password);
    log(email.toString());
    state = false;
    response.fold(
      (l) => showBanner(
        context: context,
        theMessage: l.message,
        theType: NotificationType.failure,
      ),
      (r) {
        if (r == 'success') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProfileDetailsFormView(),
            ),
          );
        } else {
          showBanner(
            context: context,
            theMessage: 'This mail has been used',
            theType: NotificationType.failure,
          );
        }
      },
    );
  }

  // input details
  Future<void> setupProfileDetails({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String userName,
  }) async {
    state = true;
    String? id = await SharedPrefs().getString(key: 'id');

    final response = await _authRepository.setupProfileDetails(
      id: id!,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      userName: userName,
    );
    log(id.toString());
    state = false;
    response.fold(
      (l) => showBanner(
        context: context,
        theMessage: l.message,
        theType: NotificationType.failure,
      ),
      (r) {
        if (r == 'success') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LoginView(),
            ),
          );
        } else {
          showBanner(
            context: context,
            theMessage: 'Error',
            theType: NotificationType.failure,
          );
        }
      },
    );
  }

  void loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = true;
    final response =
        await _authRepository.loginUser(email: email, password: password);
    log(email.toString());
    state = false;
    response.fold(
      (l) => showBanner(
        context: context,
        theMessage: l.message,
        theType: NotificationType.failure,
      ),
      (r) {
        _ref.read(userProvider.notifier).update((state) => r);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const BaseNavWrapper(),
          ),
        );
      },
    );
  }

  void logout(BuildContext context) async {
    state = true;
    final res = await _authRepository.logout();
    state = false;
    res.fold(
      (l) => log(l.message),
      (r) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const LoginView(),
        ));
        _ref.read(userProvider.notifier).update((state) => null);
      },
    );
  }

  // //! get user data
  // Future<UserModel> getUserData({required BuildContext context}) async {
  //   late UserModel user;
  //   state = true;
  //   final response = await _authRepository.getUserData();
  //   log(response.toString());
  //   state = false;
  //   response.fold(
  //     (l) => showBanner(
  //       context: context,
  //       theMessage: l.message,
  //       theType: NotificationType.failure,
  //     ),
  //     (r) {
  //       _ref.read(userProvider.notifier).update((state) => r);
  //       user = r;
  //     },
  //   );
  //   return user;
  // }
}
