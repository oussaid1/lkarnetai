part of 'login_bloc.dart';

enum LoginSattus { loading, success, error, unauthenticated }

class LoginState extends Equatable {
  final LoginSattus status;
  final User? user;
  final String error;
  LoginState({
    required this.status,
    required this.user,
    required this.error,
  });

  /// copyWith
  LoginState copyWith({
    LoginSattus? status,
    User? user,
    String? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, error];
}
