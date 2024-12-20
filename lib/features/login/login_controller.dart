import 'package:flutter/material.dart';
import 'package:qrone/features/login/login_state.dart';

class LoginController extends ValueNotifier<LoginState> {
  
  /// The navigator key
  final GlobalKey<NavigatorState> navigatorKey;

  LoginController({required this.navigatorKey}):super(createLoginState());

  void login(String username, String password) async {
    value = value.copyWith(isLoading: true);
    // Add your login logic here
    await Future.delayed(Duration(seconds: 2)); // Simulate a network call
    value = value.copyWith(isLoading: false);
  }

  togglePasswordVisibility() {
    value = value.copyWith(isPassword: !value.isPassword);
  }

  
}