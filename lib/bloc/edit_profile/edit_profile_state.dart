part of 'edit_profile_bloc.dart';

class EditProfileState {
  bool isSubmitting = false;
  bool isSuccess = false;
  bool isFailure = false;
  String filePhoto = "";
  UserModel user = UserModel();


  bool isPhoneEmpty() => user.phone.isEmpty;

  EditProfileState({
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    required this.user,
    required this.filePhoto,
  });

  factory EditProfileState.initial() {
    return EditProfileState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      user: UserModel(),
      filePhoto: "",
    );
  }

  EditProfileState loading() {
    return update(
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  EditProfileState success() {
    return update(
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  EditProfileState failure() {
    return update(
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  EditProfileState update({
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? name,
    String? gender,
    String? phone,
    String? city,
    String? state,
    String? country,
    String? photoUrl,
    String? interestedIn,
    bool? isMarried,
    bool? isOpen,
    String? filePhoto,
  }) {
    return EditProfileState(
        isSubmitting: isSubmitting ?? false,
        isSuccess: isSuccess ?? false,
        isFailure: isFailure ?? false,
        filePhoto: filePhoto ?? this.filePhoto,
        user: UserModel(
          id: user.id,
          email: user.email,
          name: name ?? user.name,
          gender: gender ?? user.gender,
          phone: phone ?? user.phone,
          city: city ?? user.city,
          state: state ?? user.state,
          country: country ?? user.country,
          interestedIn: interestedIn ?? user.interestedIn,
          isMarried: isMarried ?? user.isMarried,
          isOpen: isOpen ?? user.isOpen,
          photoUrl: photoUrl ?? user.photoUrl,
          lowercaseName: name != null ? name.toLowerCase() : user.lowercaseName,
        ));
  }
  EditProfileState updateUser({UserModel? user}){
    return EditProfileState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      filePhoto: filePhoto,
      user: user ?? this.user,
    );
  }
}
