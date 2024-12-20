import 'package:flutter/material.dart';
import 'package:ioc_container/ioc_container.dart';
import 'package:qrone/features/login/login_controller.dart';
import 'package:qrone/features/login/login_screen.dart';

void main() {
    container = compose().toContainer();
  runApp(const MyApp());
}

late final IocContainer container;

/// Register services using the builder
IocContainerBuilder compose([bool allowOverrides = false]) =>
    IocContainerBuilder(allowOverrides: allowOverrides)
      ..addSingleton(
        (container) => GlobalKey<NavigatorState>(),
      )
      // ..addSingleton(
      //   (container) => Client(),
      // )
      ..addSingleton(
        (container) => LoginController(
         navigatorKey:  container.get<GlobalKey<NavigatorState>>(),
        ),
      );


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoginPage(),
    );
  }
}
