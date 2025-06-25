import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/login_credentials.dart';
import 'package:lkarnet/models/user/user.dart';
import 'package:lkarnet/repository/database_operations.dart';
import 'package:lkarnet/services/auth_service_interface.dart';

import '../database/database.dart';
import '../providers/authproviders/auth_services.dart';

class AuthService implements AuthServiceInterface {
  final FirebaseAuthService _firebaseAuth;
  late DatabaseOperations _databaseOperations;

  AuthService(this._firebaseAuth, this._databaseOperations);
  @override
  Stream<User?> get currentUser => _firebaseAuth.authStateChange;

  @override
  bool isLoggedIn() {
    bool isLoggedIn = _firebaseAuth.currentUser != null;
    return (isLoggedIn);
  }

  @override
  Future<User> signInWithEmailAndPassword(
      {required LoginCredentials loginCredentials}) async {
    User? user = await _firebaseAuth.signIn(loginCredentials: loginCredentials);
    log('signIn AuthService' + user.toString());
    if (user != null) {
      GetIt.I<Database>().setUserUid(user.uid);
      var db = GetIt.I<Database>();
      log('signIn AuthService Db uid :' + db.uid.toString());
      _databaseOperations = DatabaseOperations(db);
      await _databaseOperations.createUser(UserModel.fromUserCredential(user));
    }

    return user!;
  }

  @override
  Future<User> signInWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<User?> signUpWithEmailAndPassword(
      {required SignUpCredentials signUpCredentials}) {
    return _firebaseAuth.signUp(signUpCredentials: signUpCredentials);
  }

  /// send password reset email
  @override
  Future<void> sendPasswordResetEmail({required String email}) {
    return _firebaseAuth.resetPass(email: email);
  }
}
