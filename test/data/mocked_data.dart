import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
 
 
 
  
/// Registers the mock handler for app_links
///
/// Returns the [EventChannel] used to mock the incoming links.
void mockAppLink({
  bool mockMethodChannel = false,
  bool mockEventChannel = false,
  String? initialLink,
}) {
  const channel = MethodChannel('com.llfbandit.app_links/messages');
  const eventChannel = MethodChannel('com.llfbandit.app_links/events');

  TestWidgetsFlutterBinding.ensureInitialized();

  // ignore: invalid_null_aware_operator
  TestDefaultBinaryMessengerBinding.instance?.defaultBinaryMessenger
      .setMockMethodCallHandler(
          channel, (call) async => mockMethodChannel ? initialLink : null,);

  // Mock event channel using method channel, to keep supporting older versions
  // of flutter_test in which setMockStreamHandler is not yet available.
  if (mockEventChannel) {
    // ignore: invalid_null_aware_operator
    TestDefaultBinaryMessengerBinding.instance?.defaultBinaryMessenger
        .setMockMethodCallHandler(
      eventChannel,
      (MethodCall methodCall) async {
        // ignore: invalid_null_aware_operator
        TestDefaultBinaryMessengerBinding.instance?.defaultBinaryMessenger
            .handlePlatformMessage(
          eventChannel.name,
          const StandardMethodCodec().encodeSuccessEnvelope(initialLink),
          (ByteData? data) {},
        );
        return null;
      },
    );
  }
}

class MockAsyncStorage extends GotrueAsyncStorage {
  final Map<String, String> _map = {};

  @override
  Future<String?> getItem({required String key}) async {
    return _map[key];
  }

  @override
  Future<void> removeItem({required String key}) async {
    _map.remove(key);
  }

  @override
  Future<void> setItem({required String key, required String value}) async {
    _map[key] = value;
  }
}
 
/// Construct session data for a given expiration date
({String accessToken, String sessionString}) getSessionData(
    DateTime accessTokenExpireDateTime,) {
  final accessTokenExpiresAt =
      accessTokenExpireDateTime.millisecondsSinceEpoch ~/ 1000;
  final accessTokenMid = base64.encode(utf8.encode(json.encode({
    'exp': accessTokenExpiresAt,
    'sub': '1234567890',
    'role': 'authenticated'
  ,}),),);
  final accessToken = 'any.$accessTokenMid.any';
  final sessionString =
      '{"access_token":"$accessToken","expires_in":${accessTokenExpireDateTime.difference(DateTime.now()).inSeconds},"refresh_token":"-yeS4omysFs9tpUYBws9Rg","token_type":"bearer","provider_token":null,"provider_refresh_token":null,"user":{"id":"4d2583da-8de4-49d3-9cd1-37a9a74f55bd","app_metadata":{"provider":"email","providers":["email"]},"user_metadata":{"Hello":"World"},"aud":"","email":"fake1680338105@email.com","phone":"","created_at":"2023-04-01T08:35:05.208586Z","confirmed_at":null,"email_confirmed_at":"2023-04-01T08:35:05.220096086Z","phone_confirmed_at":null,"last_sign_in_at":"2023-04-01T08:35:05.222755878Z","role":"","updated_at":"2023-04-01T08:35:05.226938Z"}}';
  return (accessToken: accessToken, sessionString: sessionString);
}


class MockLocalStorage extends LocalStorage {
  @override
  Future<void> initialize() async {}
  @override
  Future<String?> accessToken() async {
    return getSessionData(DateTime.now().add(const Duration(hours: 1)))
        .sessionString;
  }

  @override
  Future<bool> hasAccessToken() async => true;
  @override
  Future<void> persistSession(String persistSessionString) async {}
  @override
  Future<void> removePersistedSession() async {}
}

/// Custom HTTP client just to test the PKCE flow.
class PkceHttpClient extends BaseClient {
  int requestCount = 0;
  Map<String, dynamic> lastRequestBody = {};

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    requestCount++;

    if (request is Request) {
      lastRequestBody = jsonDecode(request.body);
    }

    final jwt = JWT(
      {'exp': (DateTime.now().millisecondsSinceEpoch / 1000).round() + 60},
      subject: '18bc7a4e-c095-4573-93dc-e0be29bada97',
    );

    return StreamedResponse(
      Stream.value(
        utf8.encode(
          jsonEncode(
            {
              'access_token': jwt.sign(
                SecretKey('37c304f8-51aa-419a-a1af-06154e63707a'),
              ),
              'token_type': 'bearer',
              'expires_in': 3600,
              'refresh_token': 'tDoDnvj5MKLuZOQ65KyVfQ',
              'user': {
                'id': '18bc7a4e-c095-4573-93dc-e0be29bada97',
                'aud': '',
                'role': '',
                'email': 'fake1@email.com',
                'email_confirmed_at': '2023-04-01T09:38:59.784028Z',
                'phone': '166600000000',
                'phone_confirmed_at': '2023-04-01T09:38:59.784028Z',
                'confirmed_at': '2023-04-01T09:38:59.784028Z',
                'last_sign_in_at': '2023-04-01T09:38:59.904492805Z',
                'app_metadata': {
                  'provider': 'email',
                  'providers': ['email'],
                },
                'user_metadata': {},
                'factors': [
                  {
                    'id': '1d3aa138-da96-4aea-8217-af07daa6b82d',
                    'created_at': '2023-04-01T09:38:59.784028Z',
                    'updated_at': '2023-04-01T09:38:59.784028Z',
                    'status': 'unverified',
                    'friendly_name': 'UnverifiedFactor',
                    'factor_type': 'totp',
                  }
                ],
                'identities': [
                  {
                    'id': '18bc7a4e-c095-4573-93dc-e0be29bada97',
                    'user_id': '18bc7a4e-c095-4573-93dc-e0be29bada97',
                    'identity_data': {
                      'email': 'fake1@email.com',
                      'sub': '18bc7a4e-c095-4573-93dc-e0be29bada97',
                    },
                    'provider': 'email',
                    'last_sign_in_at': '2023-04-01T09:38:59.784028Z',
                    'created_at': '2023-04-01T09:38:59.784028Z',
                    'updated_at': '2023-04-01T09:38:59.784028Z'
                  ,},
                ],
                'created_at': '2023-04-01T09:38:59.784028Z',
                'updated_at': '2023-04-01T09:38:59.908816Z',
              },
            },
          ),
        ),
      ),
      201,
      request: request,
    );
  }
}
