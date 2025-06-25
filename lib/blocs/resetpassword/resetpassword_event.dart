part of 'resetpassword_bloc.dart';

abstract class ResetpasswordEvent extends Equatable {
  const ResetpasswordEvent();

  @override
  List<Object> get props => [];
}

class ResetpasswordRequestedEvent extends ResetpasswordEvent {
  final String email;

  const ResetpasswordRequestedEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class ResetpasswordSuccessEvent extends ResetpasswordEvent {
  final String email;
  final String token;
  final String message;
  final String url;

  const ResetpasswordSuccessEvent({
    required this.email,
    required this.token,
    required this.message,
    required this.url,
  });

  @override
  List<Object> get props => [email, token, message, url];
}
