import '../../components.dart';
import '../../models/login_credentials.dart';
import '../../services/auth_service.dart';
import '../authbloc/auth_bloc.dart';
import '../authbloc/auth_event.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late final AuthBloc _authBloc;
  late AuthService _authService;
  // late UserCubit _userCubit;
  LoginBloc(AuthBloc authBloc, AuthService authService)
    : super(
        LoginState(
          status: LoginSattus.unauthenticated,
          user: null,
          error: 'unauthorized',
        ),
      ) {
    _authBloc = authBloc;
    _authService = authService;
    on<LoginRequestedEvent>(_onLogInRequested);
    on<LogOutRequestedEvent>(_onLogOutRequested);
    on<LoginLoadingEvent>(_onLoginLoading);
  }

  void _onLogInRequested(
    LoginRequestedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState(status: LoginSattus.loading, user: null, error: 'loading'));
    if (event.loginCredentials.isValid) {
      var response = await _authService.signInWithEmailAndPassword(
        loginCredentials: event.loginCredentials,
      );

      _authBloc.add(AuthSuccessfulEvent(user: response));
      emit(
        LoginState(
          status: LoginSattus.success,
          user: response,
          error: 'success',
        ),
      );
    } else {
      emit(
        LoginState(status: LoginSattus.unauthenticated, user: null, error: ''),
      );
    }
  }

  /// Log out the user
  void _onLogOutRequested(
    LogOutRequestedEvent event,
    Emitter<LoginState> emit,
  ) async {
    await _authService.signOut();
    _authBloc.add(NotAuthenticatedEvent());
    emit(
      LoginState(
        status: LoginSattus.unauthenticated,
        user: null,
        error: 'logout',
      ),
    );
  }

  _onLoginLoading(LoginLoadingEvent event, Emitter<LoginState> emit) async {
    emit(LoginState(status: LoginSattus.loading, user: null, error: 'loading'));
  }
}
