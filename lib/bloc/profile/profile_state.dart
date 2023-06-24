part of 'profile_bloc.dart';

class ProfileState {
  bool isSubmitting = false;
  bool isSuccess = false;
  bool isFailure = false;
  String filePhoto = "";
  UserModel user = UserModel();

  get endValid =>
      user.phone.isNotEmpty &&
      user.city.isNotEmpty &&
      user.state.isNotEmpty &&
      user.country.isNotEmpty;

  bool get initialValid =>
      filePhoto.isNotEmpty &&
      user.name.isNotEmpty &&
      user.gender.isNotEmpty &&
      user.dateOfBirth != AppStrings.maxDate &&
      user.interestedIn.isNotEmpty;

  bool isPhoneEmpty() => user.phone.isEmpty;

  ProfileState({
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    required this.user,
    required this.filePhoto,
  });

  factory ProfileState.initial() {
    return ProfileState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      user: UserModel(),
      filePhoto: "",
    );
  }

  ProfileState loading() {
    return update(
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  ProfileState success() {
    return update(
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  ProfileState failure() {
    return update(
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  ProfileState update({
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
    GeoPoint? location,
    DateTime? dateOfBirth,
    String? interestedIn,
    bool? isMarried,
    bool? isOpen,
    String? filePhoto,
  }) {
    return ProfileState(
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
          location: location ?? user.location,
          dateOfBirth: dateOfBirth ?? user.dateOfBirth,
          interestedIn: interestedIn ?? user.interestedIn,
          isMarried: isMarried ?? user.isMarried,
          isOpen: isOpen ?? user.isOpen,
          photoUrl: photoUrl ?? user.photoUrl,
          lowerCaseName: name != null ? name.toLowerCase() : user.lowerCaseName,
        ));
  }
  ProfileState updateUser({UserModel? user}){
    return ProfileState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      filePhoto: filePhoto,
      user: user ?? this.user,
    );
  }
}
