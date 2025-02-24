import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrone/features/home/home_screen.dart';
import 'package:qrone/main.dart';
import 'package:qrone/navigation/navigations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/mocked_data.dart';
import '../helper/utils.dart';

void main() {
  setUp(() async {
    mockAppLink();
    await Supabase.initialize(
      url: 'https://mock.supabase.co', // Mock URL
      anonKey: 'mock-key-12345', // Mock key
      authOptions: FlutterAuthClientOptions(
        detectSessionInUri: false,
        // Mock storage implementations
        localStorage: MockLocalStorage(),
        pkceAsyncStorage: MockAsyncStorage(),
        // Add autoRefreshToken to prevent token refresh attempts
        autoRefreshToken: false,
      ),
    );

    // Mock successful sign in response
    final mockSession = Session(
      accessToken: 'mock-access-token',
      refreshToken: 'mock-refresh-token',
      expiresIn: 3600,
      tokenType: '',
      user: User(
        id: 'id',
        appMetadata: {},
        userMetadata: {},
        aud: "",
        createdAt: "",
      ),
    );
    await Supabase.instance.client.auth.setSession(mockSession.accessToken);
  });

  tearDown(() async {
    await Supabase.instance.dispose();
  });

  testWidgets('Signing out triggers AuthChangeEvent.signedOut event',
      (tester) async {
    container = composeTest(true).toContainer();

    // Create a MaterialApp with proper navigation setup
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: container.get<GlobalKey<NavigatorState>>(),
        onGenerateRoute: AppRouter.generateRoute,
        home: HomeScreen(), // Use home instead of initialRoute
      ),
    );

    await tester.pumpAndSettle(); // Wait for initial frame

    // Verify home screen is showing first
    expect(find.byType(HomeScreen), findsOneWidget);

    // Trigger sign out
    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();

    // Verify navigation occurred
    expect(find.byType(HomeScreen), findsNothing);
    final BuildContext context = tester.element(find.byType(MaterialApp));
    expect(ModalRoute.of(context)?.settings.name, Routes.login);
  });
}
