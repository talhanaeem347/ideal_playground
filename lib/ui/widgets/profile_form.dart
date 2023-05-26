import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ideal_playground/bloc/authentication/authentication_bloc.dart';
import 'package:ideal_playground/ui/widgets/custom/simple_button.dart';
import 'package:ideal_playground/ui/widgets/profile_form_mor.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/profile/profile_bloc.dart';
import 'package:ideal_playground/repositories/user_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ideal_playground/ui/widgets/custom/my_input_field.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

import 'gender.dart';

class ProfileForm extends StatefulWidget {
  final UserRepository _userRepository;

  const ProfileForm({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  late ProfileBloc _profileBloc;

  UserRepository get _userRepository => widget._userRepository;

  _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition();
    _profileBloc.add(
      LocationChanged(
        location: GeoPoint(position.latitude, position.longitude),
      ),
    );
    return position;
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
    _profileBloc = ProfileBloc(userRepository: _userRepository);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Container(
                  height: size.height * 0.08,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.failureMessage),
                      const Icon(Icons.error),
                    ],
                  ),
                ),
              ),
            );
        }
        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Container(
                  height: size.height * 0.08,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.submitting),
                      const CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(InitialComplete());
        }
      },
      bloc: _profileBloc,
      child: BlocBuilder(
          bloc: _profileBloc,
          builder: (BuildContext context, ProfileState state) {
            return SingleChildScrollView(
                child: Container(
              color: AppColors.scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.25,
                      width: size.width,
                      child: CircleAvatar(
                        radius: size.width * 0.2,
                        backgroundColor: AppColors.red,
                        backgroundImage: state.photoUrl.isNotEmpty
                            ? FileImage(File(state.photoUrl))
                            : null,
                        child: GestureDetector(
                            child: state.photoUrl.isEmpty
                                ? Icon(
                                    Icons.add_a_photo,
                                    size: size.width * 0.1,
                                    color: AppColors.white,
                                  )
                                : null,
                            onTap: () {
                              _profileBloc.add(PhotoUrlChanged());
                            }),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    MyInputField(
                      onChanged: (value) {
                        _profileBloc.add(NameChanged(name: value));
                      },
                      label: AppStrings.name,
                      textInputType: TextInputType.name,
                      validator: (_) {
                        return state.user.name.isEmpty
                            ? AppStrings.invalidName
                            : null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            state.user.dateOfBirth.toString() ==
                                    AppStrings.maxDate.toString()
                                ? AppStrings.enterDateOfBirth
                                : DateFormat.yMMMd().format(state.user.dateOfBirth),
                            style: TextStyle(
                                fontSize: size.width * 0.08,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold)),
                        IconButton(
                          onPressed: () {
                            _profileBloc
                                .add(DateOfBirthChanged(context: context));
                          },
                          icon: Icon(
                            Icons.calendar_month,
                            size: size.width * 0.08,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppStrings.yourGender,
                            style: TextStyle(
                                fontSize: size.width * 0.08,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            genderWidget(FontAwesomeIcons.venus, "Female", size,
                                state.user.gender, () {
                              _profileBloc
                                  .add(const GenderChanged(gender: "Female"));
                            }),
                            genderWidget(FontAwesomeIcons.mars, "Male", size,
                                state.user.gender, () {
                              _profileBloc
                                  .add(const GenderChanged(gender: "Male"));
                            }),
                            genderWidget(FontAwesomeIcons.marsAndVenus, "Other",
                                size, state.user.gender, () {
                              _profileBloc
                                  .add(const GenderChanged(gender: "Other"));
                            }),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.interestedIn,
                            style: TextStyle(
                                fontSize: size.width * 0.08,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            genderWidget(FontAwesomeIcons.venus, "Female", size,
                                state.user.interestedIn, () {
                              _profileBloc.add(const InterestedInChanged(
                                  interestedIn: "Female"));
                            }),
                            genderWidget(FontAwesomeIcons.mars, "Male", size,
                                state.user.interestedIn, () {
                              _profileBloc.add(const InterestedInChanged(
                                  interestedIn: "Male"));
                            }),
                            genderWidget(FontAwesomeIcons.marsAndVenus, "Other",
                                size, state.user.interestedIn, () {
                              _profileBloc.add(const InterestedInChanged(
                                  interestedIn: "Other"));
                            }),
                          ],
                        ),
                        SizedBox(height: size.height * 0.015),
                        Container(
                          alignment: Alignment.center,
                          child: SimpleButton(
                            onPressed: () {
                              if (state.initialValid) {
                                _profileBloc
                                    .add(const ProfileSaveButtonClicked());
                              }
                            },
                            label: AppStrings.save,
                            color: state.initialValid
                                ? AppColors.white
                                : AppColors.grey,
                            textColor: AppColors.yellow,
                            height: size.height * 0.06,
                            width: size.width * 0.5,
                          ),
                        ),
                        SizedBox(height: size.height * 0.015),
                      ],
                    ),
                  ]),
            ));
          }),
    );
  }
}
