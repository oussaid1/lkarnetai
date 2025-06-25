import 'package:lkarnet/models/user/user.dart';

abstract class UserInterface {
  Future<UserModel> getUser();
  Future<void> addUser();
}