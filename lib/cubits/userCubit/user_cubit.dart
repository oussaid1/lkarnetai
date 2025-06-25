import '../../components.dart';

class UserCubit extends Cubit<User?> {
  UserCubit() : super(null) {
    _loadFromPreferences();
  }
  final String key = "isLoggedIn";
  SharedPreferences? _preferences;
  late bool _isLoggedIn = false;
  String? _token;

  bool get isLoggedIn => _isLoggedIn;

  _initialPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  _savePreferences() async {
    await _initialPreferences();
    _preferences!.setBool(key, _isLoggedIn);

    /// Save token
    if (_token != null) {
      _preferences!.setString('token', _token!);
    }
  }

  _loadFromPreferences() async {
    await _initialPreferences();
    _isLoggedIn = _preferences!.getBool(key) ?? true;

    /// Load token
    /// If token is not null, then user is logged in
    _token = _preferences!.getString('token');
  }

  toggleChangeTheme(String token) {
    /// Save token
    _token = token;
    _isLoggedIn = !_isLoggedIn;
    _savePreferences();
  }
}
