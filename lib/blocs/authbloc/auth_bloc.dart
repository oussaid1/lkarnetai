import 'dart:developer';

import 'package:lkarnet/services/auth_service.dart';

import '../../components.dart';
import 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthenticationState> {
  late AuthService _authService;
  AuthBloc(AuthService authService)
    : super(AuthenticationState(status: AuthStatus.initializing, user: null)) {
    _authService = authService;
    _buildAuthenticate();
    on<AuthLoadingEvent>(_authLoading);
    on<AuthSuccessfulEvent>(_authSuccessful);
    on<AuthFailedEvent>(_authFailed);
    on<NotAuthenticatedEvent>(_notAuthenticated);
  }

  /// dispatch event to the bloc according to the event type
  Future<void> _buildAuthenticate() async {
    _authService.currentUser.listen((event) {
      if (event != null) {
        add(AuthSuccessfulEvent(user: event));
      } else {
        add(NotAuthenticatedEvent());
      }
    });
  }

  /// on event of type AuthLoadingEvent
  Future<void> _authLoading(
    AuthLoadingEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.authenticating));
  }

  /// on event of type AuthSuccessfulEvent
  Future<void> _authSuccessful(
    AuthSuccessfulEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    log('AuthSuccessfulEvent');
    emit(state.copyWith(status: AuthStatus.authenticated, user: event.user));
  }

  /// on event of type AuthFailedEvent
  Future<void> _authFailed(
    AuthFailedEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.authenticationFailed));
  }

  /// on event of type NotAuthenticatedEvent
  Future<void> _notAuthenticated(
    NotAuthenticatedEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.unauthenticated));
  }
}
