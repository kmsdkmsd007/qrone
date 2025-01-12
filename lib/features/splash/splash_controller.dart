import 'package:flutter/material.dart';
import 'package:qrone/main.dart';
import 'package:qrone/navigation/navigations.dart';
import 'package:qrone/services/auth_service.dart';

class SplashController {
  final GlobalKey<NavigatorState> navigatorKey;

  SplashController(this.navigatorKey);

   checkAuthState()async{
        final authService = container.get<AuthService>();
    await Future.delayed(const Duration(seconds: 2)); // Add a small delay for splash screen

        if (authService.isAuthenticated) {
navigatorKey.currentState!.pushReplacementNamed(Routes.home);
    } else {
      navigatorKey.currentState!.pushReplacementNamed(Routes.login);
    }
   }
}