import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaap_mobile_app/features/auth/models/request_model.dart';
import 'package:shaap_mobile_app/features/auth/repositories/auth_repository.dart';
import 'package:shaap_mobile_app/features/auth/views/login_view.dart';
import 'package:shaap_mobile_app/features/auth/views/profile_details_form.dart';
import 'package:shaap_mobile_app/main.dart';
import 'package:shaap_mobile_app/utils/type_defs.dart';
import 'package:shaap_mobile_app/utils/utils.dart';

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

  Future<void> signUpUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
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
              builder: (context) => LoginView(
                email: email,
              ),
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

  Future<void> loginUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
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
}
