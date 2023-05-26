part of 'profile_bloc.dart';

class ProfileState {
  bool isSubmitting = false;
  bool isSuccess = false;
  bool isFailure = false;


  // String name = "";
  // String gender = "";
  // String phone = "";
  // String city = "";
  // String state = "";
  // String country = "";
  String photoUrl = "";

  // GeoPoint location = const GeoPoint(0, 0);
  // DateTime dateOfBirth = AppStrings.maxDate;
  // String interestedIn = "";
  // bool isMarried = false;
  // bool isOpen = false;
  User user = User();

  get endValid =>
      user.phone.isNotEmpty &&
          user.city.isNotEmpty &&
          user.state.isNotEmpty &&
          user.country.isNotEmpty &&
          user.interestedIn.isNotEmpty;

  bool get initialValid =>
      photoUrl.isNotEmpty &&
          user.name.isNotEmpty &&
          user.gender.isNotEmpty &&
          user.dateOfBirth != DateTime(2004, 1, 1) &&
          user.interestedIn.isNotEmpty;

  ProfileState({
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    required this.user,
    required photoUrl,
  });

  // required this.name,
  // required this.gender,
  // required this.phone,
  // required this.city,
  // required this.state,
  // required this.country,
  // required this.photoUrl,
  // required this.location,
  // required this.dateOfBirth,
  // required this.interestedIn,
  // required this.isMarried,
  // required this.isOpen});

  factory ProfileState.initial() {
    return ProfileState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      user: User(),
      photoUrl: "",
      // name: "",
      // gender: "",
      // phone: "",
      // city: "",
      // state: "",
      // country: "",
      // photoUrl: "",
      // location: const GeoPoint(0, 0),
      // dateOfBirth: DateTime(2004, 1, 1),
      // interestedIn: "",
      // isMarried: false,
      // isOpen: false,
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
  }) {
    return ProfileState(
      isSubmitting: isSubmitting ?? false,
      isSuccess: isSuccess ?? false,
      isFailure: isFailure ?? false,
      photoUrl: "",
      user: User(
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
    ));
  }
}
