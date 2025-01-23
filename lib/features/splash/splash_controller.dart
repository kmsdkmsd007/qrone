import 'package:flutter/material.dart';
import 'package:qrone/navigation/navigations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashController {
  final GlobalKey<NavigatorState> navigatorKey;

  SplashController(this.navigatorKey);

   checkAuthState()async{
        Supabase.instance.client.auth.onAuthStateChange.listen((event) {
        if (event.session!= null) {
          if(event.session!.user!=null){
            navigatorKey.currentState!.pushReplacementNamed(Routes.home);
          }else{
            navigatorKey.currentState!.pushReplacementNamed(Routes.login);
          }
    } else {
      navigatorKey.currentState!.pushReplacementNamed(Routes.login);
    }
   });
   }
}