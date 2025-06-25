part of 'resetpassword_bloc.dart';

abstract class ResetpasswordState extends Equatable {
  const ResetpasswordState();

  @override
  List<Object> get props => [];
}

class ResetpasswordInitialState extends ResetpasswordState {}

class ResetpasswordLoadingState extends ResetpasswordState {}

class ResetpasswordSuccessState extends ResetpasswordState {
  final String email;
  final String token;
  final String message;
  final String url;

  const ResetpasswordSuccessState({
    required this.email,
    required this.token,
    required this.message,
    required this.url,
  });

  @override
  List<Object> get props => [email, token, message, url];
}

class ResetpasswordErrorState extends ResetpasswordState {
  final String error;

  const ResetpasswordErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
