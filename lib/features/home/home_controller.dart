import 'package:flutter/material.dart';
import 'package:qrone/navigation/navigations.dart';
import 'package:qrone/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController {
  final GlobalKey<NavigatorState> navigatorKey;
  final AuthService _authService;

  HomeController({
    required this.navigatorKey,
    required AuthService authService,
  }) : _authService = authService;

  Future<void> logout() async {  try {
                await Supabase.instance.client.auth.signOut();
                
              } catch (_) {
                print(_);
              }
   
  }
}
