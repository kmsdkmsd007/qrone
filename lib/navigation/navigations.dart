import 'package:flutter/material.dart';
import 'package:qrone/features/home/home_screen.dart';
import 'package:qrone/features/login/login_screen.dart';
import 'package:qrone/features/products/product_details.dart';
import 'package:qrone/features/products/product_model.dart';
import 'package:qrone/features/splash/splashScreen.dart';
import 'package:qrone/features/update_product/update_product_screen.dart';

class Routes {
  static const String login = '/login';
  static const String home = '/home';
  static const String splash = '/splash';
  static const String updateProduct = '/updateProduct';
  static const String productDetails = '/productDetails';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.productDetails:
        return MaterialPageRoute(
          builder: (context) => ProductDetails(
            id: settings.arguments as int,
          ),
        );
      case Routes.updateProduct:
        return MaterialPageRoute(
          builder: (context) => UpdateProductScreen(
            selectedProduct: settings.arguments as ProductModel,
          ),
        );
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => Splashscreen());
      case Routes.login:
        return MaterialPageRoute(
          settings: settings, // Important: pass the settings
          builder: (_) => LoginPage(),
        );
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
