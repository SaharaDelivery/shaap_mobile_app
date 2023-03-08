import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaap_mobile_app/features/auth/controllers/auth_controller.dart';

class DummyHomeView extends ConsumerWidget {
  const DummyHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      body: Center(
        child: Text(user.email),
      ),
    );
  }
}
