//import 'dart:developer';

import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:lkarnet/database/database.dart';

import '../../components.dart';
import '../../models/user/user.dart';
import '../../repository/database_operations.dart';
import '../../services/auth_service.dart';

class UserModelCubit extends Cubit<UserModel?> {
  UserModelCubit() : super(null) {
    _database = Database(uid: '');
    _authService = GetIt.I<AuthService>();

    _authService.currentUser.listen((event) async {
      _database.uid = event?.uid;
    });
    loadUser();
  }
  late final AuthService _authService;
  late final Database _database;
  static const String key = "user";
  late String uid = '';

  void loadUser() async {
    var _db = DatabaseOperations(_database);
    // log("loadUser token: $token");
    await _db.getUser().then((retVal) {
      if (retVal != null) {
        log("loadUser success : ${retVal.email}");
        emit(retVal);
      }

      //log("User not loaded");
    });
  }

  void updateUser({UserModel? user}) {
    if (user != null) {
      emit((user));
    }
  }

  /// load user from shared preferences
  void loadFromCache() async {
    // var box = await Hive.openBox(key);
    // // emit(UserLoading());
    // try {
    //   final UserModel user = box.get(key);

    //   emit((user));
    // } catch (e) {
    //   emit(null);
    // }
  }

  /// save user to cache
  /// [user] is the user to be saved
  /// cache  if true, save to cache
  void cacheUSer({User? user}) async {
    // var box = await Hive.openBox(key);
    // //emit(UserLoading());
    // await box.put(key, user ?? state);
    // loadFromCache();
    //emit(const UserLoaded(user: UserModel.empty));
  }

  /// remove user from shared preferences
  void removeUserFromCache() async {
    // var box = await Hive.openBox(key);
    // await box.delete(key);
    // emit(null);
  }
}
