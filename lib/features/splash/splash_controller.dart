import 'package:flutter/material.dart';
import 'package:qrone/navigation/navigations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashController {
  final GlobalKey<NavigatorState> navigatorKey;

  SplashController(this.navigatorKey);

   checkAuthState()async{
    await Future.delayed(const Duration(seconds: 2)); // Add a small delay for splash screen

        if (Supabase.instance.client.auth.currentUser != null) {
navigatorKey.currentState!.pushReplacementNamed(Routes.home);
    } else {
      navigatorKey.currentState!.pushReplacementNamed(Routes.login);
    }
   }
}