import 'package:flutter/material.dart';

class SignUpUserRequest {
  final BuildContext context;
  final String email;
  final String password;

  SignUpUserRequest({
    required this.context,
    required this.email,
    required this.password,
  });
}
