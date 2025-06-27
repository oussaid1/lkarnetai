import 'dart:io';

import '../../components.dart';
import '../../models/user/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class EditProfileBloc extends Bloc<ProfileEvent, EditProfileState> {
  late final String token;
  // final DatabaseOperations databaseOperations;
  EditProfileBloc({required this.token}) : super(ProfileInitialState()) {
    on<ProfilePictureUploadRequestedEvent>(_onProfilePictureUploadRequested);
    on<ProfileEditRequestedEvent>(_editProfileRequested);
    on<ProfileEditFailureEvent>(
      ((event, emit) => emit(ProfileEditFailedState(event.error))),
    );
    on<ProfileEditSuccessEvent>(
      ((event, emit) => emit(ProfileEditedSuccessfuly())),
    );
    on<ProfileEditPasswordRequestedEvent>(_editPasswordRequested);
  }

  void _editProfileRequested(
    ProfileEditRequestedEvent event,
    Emitter<EditProfileState> emit,
  ) async {}

  void _editPasswordRequested(
    ProfileEditPasswordRequestedEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(ProfileEditPasswordLoadingState());
  }

  /// on profile picture upload requested
  void _onProfilePictureUploadRequested(
    ProfilePictureUploadRequestedEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(ProfilePictureUploadingState());
  }

  /// upload profile picture
  Future<bool> uploadProfilePicture(File image) async {
    return true;
  }
}
