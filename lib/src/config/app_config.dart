import 'package:food_delivery/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:firebase_storage/firebase_storage.dart';

import '../services/local_notification_service.dart';

class AppConfig {
  AppConfig._();
  static FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  static FirebaseFirestore get firestore => FirebaseFirestore.instanceFor(app: Firebase.app(), databaseId: 'food-delivery-db');
  static FirebaseStorage get storage => FirebaseStorage.instance;


  static Future<void> init() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await GoogleSignIn.instance.initialize();
    await dotenv.load();

    final stripePublishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'];
    if (stripePublishableKey != null && stripePublishableKey.isNotEmpty) {
      Stripe.publishableKey = stripePublishableKey;
      await Stripe.instance.applySettings();
    }

    await LocalNotificationService.instance.init();
  }
}
