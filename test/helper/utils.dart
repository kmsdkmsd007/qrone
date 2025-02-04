import 'package:flutter/material.dart';
import 'package:ioc_container/ioc_container.dart';
import 'package:mockito/mockito.dart';
import 'package:qrone/features/home/home_controller.dart';
import 'package:qrone/features/login/login_controller.dart';
import 'package:qrone/features/splash/splash_controller.dart';
 
import 'package:qrone/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
 

class MockNavigatorState extends Mock implements NavigatorState {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MockNavigatorState';
  }
}

var dummySession=Session(accessToken: "", tokenType: '', user: dummyUser, expiresIn: 0, refreshToken: '', providerToken: '',);
var dummyUser=User(email: '', id: '11', aud: '',createdAt: '', userMetadata: {}, appMetadata: {}, role: '',);
 
MockNavigatorState getMockNavigatorState(){
  return MockNavigatorState();
}
 

/// Register Test services using the builder
IocContainerBuilder composeTest([bool allowOverrides = false]) =>
    IocContainerBuilder(allowOverrides: allowOverrides)
      ..addSingleton(
        (container) => GlobalKey<NavigatorState>(),
      )
      ..addSingleton((container) => AuthService(Supabase.instance.client))
      
      ..addSingleton((container) => SplashController(container.get<GlobalKey<NavigatorState>>()))
      ..addSingleton(
        (container) => LoginController(
          navigatorKey: GlobalKey<MockNavigatorState>(),
          authService: container.get<AuthService>(),
        ),
      )
      ..addSingleton(
        (container) => HomeController(
          navigatorKey: container.get<GlobalKey<NavigatorState>>(),
          
        ),
      );
