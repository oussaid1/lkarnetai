part of 'auth_bloc.dart';

enum AuthStatus {
  initializing,
  authenticating,
  authenticated,
  unauthenticated,
  authenticationFailed,
}

/// State of the auth bloc when the user is authenticated.
class AuthenticationState extends Equatable {
  final AuthStatus status;
  final User? user;
  final String? error;
  const AuthenticationState(
      {required this.user, required this.status, this.error});

  /// copy with
  AuthenticationState copyWith({
    AuthStatus? status,
    User? user,
    String? error,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status];
}
