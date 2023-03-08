// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shaap_mobile_app/features/auth/controllers/auth_controller.dart';
import 'package:shaap_mobile_app/features/auth/views/login_view.dart';
import 'package:shaap_mobile_app/features/auth/views/profile_details_form.dart';
import 'package:shaap_mobile_app/features/auth/views/sign_up_view.dart';
import 'package:shaap_mobile_app/features/dummy_home_view.dart';
import 'package:shaap_mobile_app/features/onboarding/views/onboarding_view.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/utils/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final String token = await SharedPrefs().getString(key: 'x-auth-token') ?? '';

  runApp(
    ProviderScope(
      child: MyApp(
        token: token,
      ),
    ),
  );
}

final navigatorKeyProvider =
    Provider.autoDispose<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});

class MyApp extends ConsumerWidget {
  final String token;
  const MyApp({
    super.key,
    required this.token,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: ref.watch(navigatorKeyProvider),
          title: AppTexts.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Outfit'),
          home: token != '' && user != null
              ? const DummyHomeView()
              : const OnboardingView(),
        );
      },
    );
  }
}
