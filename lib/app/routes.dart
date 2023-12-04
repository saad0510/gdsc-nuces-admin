import 'package:flutter/material.dart';

import '../features/auth/screens/splash_screen.dart';
import '../features/club/screens/home_screen.dart';

enum AppRoutes {
  splash,
  home,
  ;

  static const initial = splash;

  static Route<dynamic> onGenerateRoute(RouteSettings route) {
    final appRoute = values.byName(route.name!);

    switch (appRoute) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
    }
  }
}
