part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

/// on profile picture upload requested
class ProfileEditRequestedEvent extends ProfileEvent {
  final UserModel userProfileModel;
  const ProfileEditRequestedEvent(this.userProfileModel);

  @override
  List<Object> get props => [userProfileModel];
}

class ProfileEditSuccessEvent extends ProfileEvent {}

class ProfileEditFailureEvent extends ProfileEvent {
  final String error;
  const ProfileEditFailureEvent(this.error);

  @override
  List<Object> get props => [error];
}

class ProfileEditPasswordRequestedEvent extends ProfileEvent {
  final ChangePasswordModel changePasswordModel;
  const ProfileEditPasswordRequestedEvent(this.changePasswordModel);
  @override
  List<Object> get props => [changePasswordModel];
}

class ChangePasswordModel {}

class ProfileEditPasswordSuccessEvent extends ProfileEvent {
  final ChangePasswordModel changePasswordModel;
  const ProfileEditPasswordSuccessEvent(this.changePasswordModel);
  @override
  List<Object> get props => [changePasswordModel];
}

class ProfileEditPasswordFailureEvent extends ProfileEvent {
  final String error;
  const ProfileEditPasswordFailureEvent(this.error);
  @override
  List<Object> get props => [error];
}

class ProfilePictureUploadRequestedEvent extends ProfileEvent {
  final File image;
  const ProfilePictureUploadRequestedEvent(this.image);
  @override
  List<Object> get props => [image];
}
