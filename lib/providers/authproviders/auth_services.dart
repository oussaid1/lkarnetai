import 'dart:convert';

import 'package:lkarnet/models/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../models/login_credentials.dart';

class FirebaseAuthService {
  late final FirebaseAuth _firebaseAuth;
  // final gooleSignIn = GoogleSignIn();
  FirebaseAuthService() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  /// get current user
  User? get currentUser => _firebaseAuth.currentUser;
  static Map<String, dynamic>? parseJwt(String? token) {
    // validate token
    if (token == null) return null;
    final List<String> parts = token.split('.');
    if (parts.length != 3) {
      return null;
    }
    // retrieve token payload
    final String payload = parts[1];
    final String normalized = base64Url.normalize(payload);
    final String resp = utf8.decode(base64Url.decode(normalized));
    // convert to Map
    final payloadMap = json.decode(resp);
    if (payloadMap is! Map<String, dynamic>) {
      return null;
    }
    return payloadMap;
  }

  Future<User?> signIn({required LoginCredentials loginCredentials}) async {
    try {
      var userCredentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: loginCredentials.username!,
        password: loginCredentials.password!,
      );

      return userCredentials.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return null;
      }

      if (e.code == 'wrong-password') {
        return null;
      }
      throw e;
    } on PlatformException catch (e) {
      throw e;
    }
  }

  Future<User?> signUp({required SignUpCredentials signUpCredentials}) async {
    try {
      var userCredentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: signUpCredentials.username!,
        password: signUpCredentials.password!,
      );

      return userCredentials.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return null;
      }

      if (e.code == 'wrong-password') {
        return null;
      }
      throw e;
    } on PlatformException catch (e) {
      throw e;
    }
  }

  Future<bool> signOut() async {
    await _firebaseAuth.signOut();

    return Future.value(true);
  }

  Future<bool> createNewUser(UserModel user) async {
    bool _done = false;
    await users
        .doc(user.id)
        .set(user.toMap())
        .then((value) => _done = true)
        .catchError((error) {
      print("Failed to add user: $error");
      return _done = false;
    });
    return _done;
  }

  Future<UserModel> getUser(String uid) async {
    return await users
        .doc(uid)
        .get()
        .then(
            (value) => UserModel.fromDocumentSnapshot(documentSnapshot: value))
        // ignore: return_of_invalid_type_from_catch_error
        .catchError((e) => print(e));
  }

  static Future<void> pop() async {
    await SystemChannels.platform
        .invokeMethod<void>('SystemNavigator.pop', true);
  }

  /// send password reset email
  Future resetPass({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {}
  }
}
