import '../../components.dart';
import '../../models/login_credentials.dart';
import '../../services/auth_service.dart';
import '../authbloc/auth_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignupEvent, SignUpState> {
  // late AuthBloc _authBloc;
  late final AuthService _authService;

  /// initialize the bloc with the authBloc and authService
  ///
  SignUpBloc(AuthBloc authBloc, AuthService authService)
    : super(SignupInitial()) {
    //  _authBloc = authBloc;
    _authService = authService;
    on<SignUpRequestedEvent>(_onSignUpRequested);
  }

  /// sign up the user with the email and password and return the user if successful or throw an error if not successful
  void _onSignUpRequested(
    SignUpRequestedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignupLoading());
    if (event.signUpCredentials.isValid) {
      var response = await _authService.signUpWithEmailAndPassword(
        signUpCredentials: event.signUpCredentials,
      );
      emit(SignUpSuccessfulState(user: response!));
    } else {
      emit(SignupCredentialsInvalid());
    }
  }
}
