import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrone/features/home/home_screen.dart';
import 'package:qrone/main.dart';
import 'package:qrone/navigation/navigations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/mocked_data.dart';
import '../helper/utils.dart';

void main() {
  setUp(() {
    mockAppLink();
  });

  testWidgets('Signing out triggers AuthChangeEvent.signedOut event',
      (tester) async {
    await Supabase.initialize(
      url: "",
      anonKey: "",
      authOptions: FlutterAuthClientOptions(
        localStorage: MockLocalStorage(),
        pkceAsyncStorage: MockAsyncStorage(),
      ),
    );
    
    container = composeTest(true).toContainer();
    
    // Create a MaterialApp with proper navigation setup
    await tester.pumpWidget(MaterialApp(
      navigatorKey: container.get<GlobalKey<NavigatorState>>(),
      onGenerateRoute: AppRouter.generateRoute,
      home: const HomeScreen(),
    ));

    // Trigger sign out
    await tester.tap(find.text('Sign out'));
    
    // Wait for animations and navigation
    await tester.pump();
    await tester.pumpAndSettle();

    // Verify navigation occurred
    expect(
      find.byType(HomeScreen),
      findsNothing,
      reason: 'Home screen should not be visible after logout',
    );
    
    final Route<dynamic>? currentRoute = ModalRoute.of(tester.element(find.byType(MaterialApp)));
    expect(currentRoute, isA<MaterialPageRoute>());
    expect(currentRoute?.settings.name, Routes.login);
  });
}