part of 'profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

/// ProfileInitial is the initial state of the ProfileBloc.
class ProfileInitialState extends EditProfileState {}

/// ProfileLoading is the state of the ProfileBloc when it is loading.
class ProfileLoadingState extends EditProfileState {}

/// ProfileLoaded is the state of the ProfileBloc when it has loaded.
class ProfileLoadedState extends EditProfileState {
  final UserModel userProfileModel;
  const ProfileLoadedState(this.userProfileModel);
  @override
  List<Object> get props => [userProfileModel];
}

/// ProfileFailure is the state of the ProfileBloc when it fails.
class ProfileEditFailedState extends EditProfileState {
  final String error;
  const ProfileEditFailedState(this.error);
  @override
  List<Object> get props => [error];
}

/// ProfileEditLoading is the state of the ProfileBloc when it is loading.
class ProfileEditLoadingState extends EditProfileState {}

/// ProfileEditLoaded is the state of the ProfileBloc when it has loaded.
class ProfileEditedSuccessfuly extends EditProfileState {}

////////////////////////////
///password profileinfo
class ProfileEditPasswordLoadingState extends EditProfileState {}

class ProfilePasswordEditedSuccessfuly extends EditProfileState {}

/// ProfileEditPasswordFailure is the state of the ProfileBloc when it fails.
class ProfileEditPasswordFailureState extends EditProfileState {
  final String error;
  const ProfileEditPasswordFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class ProfilePictureUploadingState extends EditProfileState {}

class ProfilePictureUploadedState extends EditProfileState {}

class ProfilePictureUploadFailureState extends EditProfileState {
  final String error;
  const ProfilePictureUploadFailureState(this.error);
}
