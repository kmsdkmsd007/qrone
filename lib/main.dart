import 'package:flutter/material.dart';
import 'package:ioc_container/ioc_container.dart';
import 'package:qrone/features/home/home_controller.dart';
import 'package:qrone/features/login/login_controller.dart';
import 'package:qrone/features/splash/splash_controller.dart'; 
import 'package:qrone/navigation/navigations.dart';
import 'package:qrone/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

late IocContainer container;

void main() async {
   await Supabase.initialize(
    url: 'https://zaqwakqcugnlnpqrsjkv.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InphcXdha3FjdWdubG5wcXJzamt2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY0ODAyNzMsImV4cCI6MjA1MjA1NjI3M30.DIMKuYzz_BHrZ-VrGivDVaAorNjY3IJQlaTQlhLB1jY',
  );
  if (!_isContainerInitialized()) {
    container = compose().toContainer();
  }
  runApp(const MyApp());
}

bool _isContainerInitialized() {
  try {
    container;
    return true;
  } catch (_) {
    return false;
  }
}

/// Register services using the builder
IocContainerBuilder compose([bool allowOverrides = false]) =>
    IocContainerBuilder(allowOverrides: allowOverrides)
      ..addSingleton(
        (container) => GlobalKey<NavigatorState>(),
      )
      ..addSingleton(
        (container) => AuthService(Supabase.instance.client),
      )
      ..addSingleton((container) => SplashController(container.get<GlobalKey<NavigatorState>>()))
      ..addSingleton(
        (container) => LoginController(
          navigatorKey: container.get<GlobalKey<NavigatorState>>(),
          authService: container.get<AuthService>(),
        ),
      )
      ..addSingleton(
        (container) => HomeController(
          navigatorKey: container.get<GlobalKey<NavigatorState>>(),
          authService: container.get<AuthService>(),
        ),
      );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: container.get<GlobalKey<NavigatorState>>(),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: Routes.splash, // Change this to splash route
    );
  }
}
