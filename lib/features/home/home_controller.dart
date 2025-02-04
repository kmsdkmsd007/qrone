import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends ValueNotifier<int> {
  final GlobalKey<NavigatorState> navigatorKey;

  HomeController({
    required this.navigatorKey,
  }) : super(0);
  changeIndex(int v) {
    value = v;
  }

  Future<void> logout() async {
    try {
      await Supabase.instance.client.auth.signOut();
    } catch (_) {
      print(_);
    }
  }
}
