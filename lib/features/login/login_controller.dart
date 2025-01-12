import 'package:flutter/material.dart';
import 'package:qrone/features/login/login_state.dart';
import 'package:qrone/navigation/navigations.dart';
import 'package:qrone/services/auth_service.dart';

class LoginController extends ValueNotifier<LoginState> {
  final GlobalKey<NavigatorState> navigatorKey;
  final AuthService _authService;

  LoginController({
    required this.navigatorKey,
    required AuthService authService,
  })  : _authService = authService,
        super(createLoginState());
        
  // LoginController({required this.navigatorKey}):super(createLoginState());

  void togglePasswordVisibility() {
    value = value.copyWith(isPassword: !value.isPassword);
  }

  Future<void> login(String email, String password) async {
    try {
      await _authService.signIn(email, password);
      navigatorKey.currentState?.pushReplacementNamed(Routes.home);
    } catch (e) {
      // Handle login errors
      debugPrint(e.toString());
    }
  }
}