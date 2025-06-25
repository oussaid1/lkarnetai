import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lkarnet/providers/authproviders/auth_services.dart';
import 'package:lkarnet/repository/database_operations.dart';
import 'app.dart';
import 'components.dart';
import 'database/database.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings();
  await FirebaseAppCheck.instance
      // Your personal reCaptcha public key goes here:
      .activate(
          // webRecaptchaSiteKey: '6D035D8A-1A94-4DBD-927D-9A21F4C36730',
          );

  /// register Database singleton
  GetIt.I.registerSingleton<Database>(Database(uid: null));
  GetIt.I.registerSingleton<DatabaseOperations>(
      DatabaseOperations(GetIt.I<Database>()));
  GetIt.I.registerSingleton<AuthService>(
    AuthService(
      FirebaseAuthService(),
      DatabaseOperations(GetIt.I.get<Database>()),
    ),
  );
  runApp(
    ProviderScope(
      child: MyApp(
        authService: GetIt.I.get<AuthService>(),
      ),
    ),
  );
}
