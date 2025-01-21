// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:qrone/services/auth_service.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import '../data/supabasemock.mocks.dart';

 
//  class SupabaseWrapper {
//   SupabaseClient get client => Supabase.instance.client;
// }
// class MockSupabaseWrapper extends Mock implements SupabaseWrapper {}

// void main() {
  
//   late MockSupabaseClient mockSupabaseClient;
//   late MockGoTrueClient mockSupabaseAuth;
//     late MockSupabaseWrapper mockSupabaseWrapper;

//   late MockSupabaseQueryBuilder mockSupabaseQueryBuilder;

//   setUp(()async {
    
    
//     mockSupabaseClient = MockSupabaseClient();
//      mockSupabaseWrapper = MockSupabaseWrapper();
//          when(mockSupabaseWrapper.client).thenReturn(mockSupabaseClient);

    
//     mockSupabaseAuth = MockGoTrueClient();
//     mockSupabaseQueryBuilder = MockSupabaseQueryBuilder();
//   });

//   test('should mock a Supabase auth call', () async {
//     // Stub the signInWithPassword method
//     when(mockSupabaseAuth.signInWithPassword(
//       email: anyNamed('email'),
//       password: anyNamed('password'),
//     )).thenAnswer((_) async => AuthResponse(
//           session: null,
//           user: User(
//             id: 'mock_user_id',
//             appMetadata: {'provider': 'email'},
//             userMetadata: {},
//             aud: 'authenticated',
//             createdAt: DateTime.now().toString(),
//             updatedAt: DateTime.now().toString(),
//           ),
//         ));

//     // Call the method
//     final result = await mockSupabaseAuth.signInWithPassword(
//       email: 'test@example.com',
//       password: 'password123',
//     );

//     // Verify the behavior
//     expect(result.user?.id, 'mock_user_id');
//     verify(mockSupabaseAuth.signInWithPassword(
//       email: 'test@example.com',
//       password: 'password123',
//     )).called(1);
//   });
 
//   late AuthService authService;

//   setUp(() {
//     mockSupabaseClient = MockSupabaseClient();
//     mockSupabaseAuth = MockGoTrueClient();

//     // Stub the client.auth property to return the mock auth
//     when(mockSupabaseClient.auth).thenReturn(mockSupabaseAuth);

//     // Initialize AuthService with the mocked client
//     authService = AuthService(mockSupabaseClient);   
//   });

//   test('should clear session and user after signOut', () async {
//      await Supabase.initialize(
//     url: 'https://zaqwakqcugnlnpqrsjkv.supabase.co',
//     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InphcXdha3FjdWdubG5wcXJzamt2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY0ODAyNzMsImV4cCI6MjA1MjA1NjI3M30.DIMKuYzz_BHrZ-VrGivDVaAorNjY3IJQlaTQlhLB1jY',
//   );
//     // Stub the signOut method to return a Future<void>
//     // when(Supabase.instance).thenReturn(mockSupabaseClient)
//     when(mockSupabaseAuth.signOut()).thenAnswer((_) async => Future.value());

//     // Stub currentSession and currentUser to return null after signOut
//     when(mockSupabaseAuth.currentSession).thenReturn(null);
//     when(mockSupabaseAuth.currentUser).thenReturn(null);

//     // Call the signOut method
//     await authService.signOut();

//     // Verify that the signOut method was called once
//     verify(mockSupabaseAuth.signOut()).called(1);

//     // Verify that currentSession and currentUser are null
//     expect(authService.session, isNull);
//     expect(authService.currentUser, isNull);
//   });
  


// }







import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import '../data/mocked_data.dart';
import '../data/supabasemock.mocks.dart';

@GenerateNiceMocks([MockSpec<GoTrueClient>()])
// import 'auth_test.mocks.dart';

void main() {
  late MockGoTrueClient mockGoTrueClient;
  late SupabaseClient supabaseClient;

  setUp(() {
    mockGoTrueClient = MockGoTrueClient();
    supabaseClient = SupabaseClient(
      'YOUR_SUPABASE_URL',
      'YOUR_SUPABASE_ANON_KEY',
      authOptions: FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
        localStorage: MockLocalStorage(),
        pkceAsyncStorage: MockAsyncStorage()
        ,
      ),
    );
  });

  group('Sign out tests', () {
    test('should successfully sign out and clear session', () async {
      // Arrange
      when(mockGoTrueClient.signOut()).thenAnswer((_) async {});
      
      // Set initial session
      final session = Session(
        accessToken: 'fake_token',
        tokenType: 'bearer',
        user: User(
          id: 'user_id',
          email: 'test@example.com',
          appMetadata: {},
          userMetadata: {},
          aud: 'authenticated',
          createdAt: DateTime.now().toIso8601String(),
        ),
      );
      when(mockGoTrueClient.currentSession).thenReturn(session);
      when(mockGoTrueClient.currentUser).thenReturn(session.user);

      // Act
      await supabaseClient.auth.signOut();

      // Assert
      verify(mockGoTrueClient.signOut()).called(1);
      
      // Verify session and user are cleared
      when(mockGoTrueClient.currentSession).thenReturn(null);
      when(mockGoTrueClient.currentUser).thenReturn(null);
      
      expect(supabaseClient.auth.currentSession, isNull);
      expect(supabaseClient.auth.currentUser, isNull);
    });

    test('should handle sign out errors', () async {
      // Arrange
      when(mockGoTrueClient.signOut()).thenThrow(
        AuthException('Sign out failed'),
      );

      // Act & Assert
      expect(
        () => supabaseClient.auth.signOut(),
        throwsA(isA<AuthException>()),
      );
    });
  });
}