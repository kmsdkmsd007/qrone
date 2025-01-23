import 'package:flutter/material.dart';
import 'package:ioc_container/ioc_container.dart';
import 'package:qrone/features/categories/category_controller.dart';
import 'package:qrone/features/home/home_controller.dart';
import 'package:qrone/features/login/login_controller.dart';
import 'package:qrone/features/splash/splash_controller.dart'; 
import 'package:qrone/navigation/navigations.dart';
import 'package:qrone/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

late IocContainer container;

void main() async {
 await Supabase.initialize(
    url: 'https://ujtyprurykbhwtxprlxz.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVqdHlwcnVyeWtiaHd0eHBybHh6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjY1NjkxNzYsImV4cCI6MjA0MjE0NTE3Nn0.2c-H_C4XPofhfDS70Ow09Hf-rcu6rRmK3L79unvBaOU',
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
      ..addSingleton((container) => CategoryController(authService: container.get<AuthService>(), navigatorKey:  container.get<GlobalKey<NavigatorState>>()))
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
