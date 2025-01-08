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

  setUp(() {
    // Reset container before each test
    container = compose(true).toContainer();
  });

  testWidgets('LoginPage renders correctly and handles interactions', (WidgetTester tester) async {
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

  testWidgets('LoginPage shows validation errors when fields are empty', (WidgetTester tester) async {
    // Create a mock LoginController
    final mockController = container.get<LoginController>();
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

     // Find and tap the sign-in button without entering any text
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    // Take a golden screenshot of the validation errors
    await expectLater(
      find.byType(LoginPage),
      matchesGoldenFile('goldens/login_screen_validation_errors.png'),
    );

    // Verify error messages are displayed
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('Password visibility toggle works correctly', (WidgetTester tester) async {
    final mockController = container.get<LoginController>();
    final materialTheme = MaterialTheme(Typography.material2021().black);

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

    // Check initial state (password should be hidden)
    final passwordFieldFinder = find.byType(TextFormField).at(1);
    final TextField passwordField = tester.widget<TextField>(
      find.descendant(
        of: passwordFieldFinder,
        matching: find.byType(TextField),
      ),
    );
    
    // Check initial state
    expect(
      passwordField.obscureText,
      true,
      reason: 'Password should be hidden initially',
    );

    // Take a golden screenshot of the initial state
    await expectLater(
      find.byType(LoginPage),
      matchesGoldenFile('goldens/password_hidden.png'),
    );

    // Find and tap the visibility toggle icon
    final visibilityIcon = find.byIcon(Icons.visibility);
    expect(visibilityIcon, findsOneWidget);
    await tester.tap(visibilityIcon);
    await tester.pumpAndSettle();

    // Get the updated TextField widget
    final updatedPasswordField = tester.widget<TextField>(
      find.descendant(
        of: passwordFieldFinder,
        matching: find.byType(TextField),
      ),
    );

    // Verify password is now visible
    expect(
      updatedPasswordField.obscureText,
      isFalse,
      reason: 'Password should be visible after toggle',
    );

    // Take a golden screenshot of the visible state
    await expectLater(
      find.byType(LoginPage),
      matchesGoldenFile('goldens/password_visible.png'),
    );

    // Test toggling back to hidden
    final visibilityOffIcon = find.byIcon(Icons.visibility_off);
    expect(visibilityOffIcon, findsOneWidget);
    await tester.tap(visibilityOffIcon);
    await tester.pumpAndSettle();

    // Get the final TextField widget state
    final finalPasswordField = tester.widget<TextField>(
      find.descendant(
        of: passwordFieldFinder,
        matching: find.byType(TextField),
      ),
    );

    // Verify password is hidden again
    expect(
      finalPasswordField.obscureText,
      isTrue,
      reason: 'Password should be hidden after toggling back',
    );
  });
}
