import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrone/features/login/login_screen.dart';
import 'package:qrone/features/login/login_controller.dart';
import 'package:qrone/features/login/login_state.dart';
import 'package:ioc_container/ioc_container.dart';
import 'package:qrone/main.dart';
import 'package:qrone/theme.dart';

IocContainerBuilder compose([bool allowOverrides = false]) =>
    IocContainerBuilder(allowOverrides: allowOverrides)
      ..addSingleton(
        (container) => GlobalKey<NavigatorState>(),
      )
      ..addSingleton(
        (container) => LoginController(
         navigatorKey:  container.get<GlobalKey<NavigatorState>>(),
        ),
      );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('LoginPage renders correctly and handles interactions', (WidgetTester tester) async {
    // Override the IoC container
    container = compose().toContainer();

    // Create a mock LoginController
    final mockController = container.get<LoginController>();

    // Create MaterialTheme instance
    final materialTheme = MaterialTheme(Typography.material2021().black);

    // Build the LoginPage widget with theme
    await tester.pumpWidget(
      MaterialApp(
        theme: materialTheme.light(),
        home: ValueListenableBuilder<LoginState>(
          valueListenable: mockController,
          builder: (context, value, child) {
            return LoginPage();
          },
        ),
      ),
    );

    // Verify initial state
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Sign in'), findsOneWidget);

    // Take the golden screenshot
    await expectLater(
      find.byType(LoginPage),
      matchesGoldenFile('goldens/LoginScreenInitial.png'),
    );

    // Enter text into the fields
    await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.pump();

    // Tap the sign-in button
    await tester.tap(find.text('Sign in'));
    await tester.pump();

    // Wait for animations/state changes
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });
}
