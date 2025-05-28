import 'package:flutter/material.dart';
import 'package:qrone/features/login/login_state.dart';
import 'package:qrone/navigation/navigations.dart';
import 'package:qrone/services/auth_service.dart';
import 'package:qrone/state/extensions/exception_helper.dart';

class LoginController extends ValueNotifier<LoginState> {
  final GlobalKey<NavigatorState> navigatorKey;
  final AuthService _authService;

  LoginController({
    required this.navigatorKey,
    required AuthService authService,
  }) : _authService = authService,
       super(createLoginState());

  // LoginController({required this.navigatorKey}):super(createLoginState());

  void togglePasswordVisibility() {
    value = value.copyWith(isPassword: !value.isPassword);
  }

  Future<void> login(String email, String password) async {
    value = value.copyWith(isLoading: true);
    try {
      await _authService.signIn(email, password);
      navigatorKey.currentState?.pushReplacementNamed(Routes.home);
      value = value.copyWith(isLoading: true);
      ScaffoldMessenger.of(
        navigatorKey.currentState!.context,
      ).showSnackBar(const SnackBar(content: Text('Login successful')));
    } catch (e) {
      value = value.copyWith(
        isLoading: false,
        error: (e as Exception).getErrorMessage(),
      );
      ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
        SnackBar(content: Text((e as Exception).getErrorMessage())),
      );

      // Handle login errors
      debugPrint(e.toString());
    }
  }
}
