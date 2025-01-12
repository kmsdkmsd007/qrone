import 'package:flutter/material.dart';
import 'package:qrone/features/splash/splash_controller.dart';
import 'package:qrone/main.dart';
import 'package:qrone/services/auth_service.dart';
import 'package:qrone/navigation/navigations.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
 container.get<SplashController>().checkAuthState();  }

 
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}