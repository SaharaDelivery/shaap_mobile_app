import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaap_mobile_app/features/auth/views/login_view.dart';
import 'package:shaap_mobile_app/features/auth/views/profile_details_form.dart';
import 'package:shaap_mobile_app/features/auth/views/sign_up_view.dart';
import 'package:shaap_mobile_app/features/onboarding/views/onboarding_view.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp(
          title: AppTexts.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Outfit'
          ),
          home: const OnboardingView(),
        );
      },
    );
  }
}
