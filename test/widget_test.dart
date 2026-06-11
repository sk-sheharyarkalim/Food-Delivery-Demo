import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:food_delivery/src/app.dart';

class _FakeFirebaseAppPlatform extends FirebaseAppPlatform {
  _FakeFirebaseAppPlatform()
      : super(
          defaultFirebaseAppName,
          const FirebaseOptions(
            apiKey: 'fake-api-key',
            appId: 'fake-app-id',
            messagingSenderId: 'fake-sender-id',
            projectId: 'fake-project-id',
          ),
        );
}

class _FakeFirebasePlatform extends FirebasePlatform {
  final _app = _FakeFirebaseAppPlatform();

  @override
  FirebaseAppPlatform app([String name = defaultFirebaseAppName]) => _app;

  @override
  List<FirebaseAppPlatform> get apps => [_app];

  @override
  Future<FirebaseAppPlatform> initializeApp({
    String? name,
    FirebaseOptions? options,
  }) async => _app;
}

void main() {
  setUpAll(() {
    Firebase.delegatePackingProperty = _FakeFirebasePlatform();
  });

  testWidgets('App should build', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    await tester.pumpWidget(
      const App()
    );

    // Verify that our base app builds successfully.
    expect(find.byType(App), findsOneWidget);
  });
}
