// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';

import 'package:shaap_mobile_app/features/auth/controllers/auth_controller.dart';
import 'package:shaap_mobile_app/features/auth/repositories/auth_repository.dart';
import 'package:shaap_mobile_app/models/error_model.dart';
import 'package:shaap_mobile_app/router.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/utils/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  ErrorModel? errorModel;

  void getUserData() async {
    errorModel = await ref.read(authRepositoryProvider).getUserData();

    if (errorModel != null && errorModel!.data != null) {
      ref.read(userProvider.notifier).update((state) => errorModel!.data);
    }
    String? token = await SharedPrefs().getString(key: 'x-auth-token');
    log(token.toString());
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp.router(
          title: AppTexts.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Outfit'),
          routeInformationParser: const RoutemasterParser(),
          routerDelegate: RoutemasterDelegate(
            routesBuilder: (context) {
              if (user != null && user.token.isNotEmpty) {
                return loggedInRoute;
              } else {
                return loggedOutRoute;
              }
            },
          ),
          // home: user != null && user.token.isNotEmpty
          //     ? const BaseNavWrapper()
          //     : const OnboardingView(),
        );
      },
    );
  }
}
