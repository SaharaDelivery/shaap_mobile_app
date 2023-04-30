import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shaap_mobile_app/features/base_nav_wrapper/views/base_nav_wrapper.dart';
import 'package:shaap_mobile_app/features/onboarding/views/onboarding_view.dart';

final loggedOutRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(
          child: OnboardingView(),
        ),
  },
);

final loggedInRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(
          child: BaseNavWrapper(),
        ),
  },
);
