import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends ValueNotifier<int> {
  final GlobalKey<NavigatorState> navigatorKey;

  HomeController({required this.navigatorKey}) : super(0);

  void changeIndex(int index) {
    value = index;
  }

  Future<void> logout() async {
    try {
      await Supabase.instance.client.auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
