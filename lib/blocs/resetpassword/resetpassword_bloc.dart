import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/auth_service.dart';
import '../authbloc/auth_bloc.dart';

part 'resetpassword_event.dart';
part 'resetpassword_state.dart';

class ResetpasswordBloc extends Bloc<ResetpasswordEvent, ResetpasswordState> {
  // late final AuthBloc _authBloc;
  late final AuthService _authService;
  ResetpasswordBloc(AuthService authService, AuthBloc authBloc)
      : super(ResetpasswordInitialState()) {
    _authService = authService;
    // _authBloc = authBloc;
    on<ResetpasswordRequestedEvent>(_onResetpasswordRequested);
  }

  void _onResetpasswordRequested(
      ResetpasswordRequestedEvent event, Emitter emit) async {
    try {
      await _authService.sendPasswordResetEmail(email: event.email);
      emit(ResetpasswordSuccessEvent(
          email: event.email, token: '', message: '', url: ''));
    } catch (e) {
      emit(ResetpasswordErrorState(error: e.toString()));
    }
  }
}
