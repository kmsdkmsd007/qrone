import 'package:flutter/material.dart';
import 'package:qrone/features/home/home_screen.dart';
import 'package:qrone/features/login/login_screen.dart';
import 'package:qrone/features/splash/splashScreen.dart';

class Routes {
  static const String login = '/login';
  static const String home = '/home';
  static const String splash = '/splash';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => Splashscreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
