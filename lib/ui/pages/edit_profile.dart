import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ideal_playground/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:ideal_playground/repositories/user_repository.dart';
import 'package:ideal_playground/ui/widgets/custom/my_input_field.dart';
import 'package:ideal_playground/ui/widgets/custom/simple_button.dart';
import 'package:ideal_playground/ui/widgets/custom/toses.dart';
import 'package:ideal_playground/ui/widgets/gender.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  final UserRepository userRepository;
  final String uid;

  const EditProfileScreen(
      {super.key, required this.userRepository, required this.uid});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late EditProfileBloc _editProfileBloc;
  late UserModel user;

  getDetails() async {
    user = await widget.userRepository.getUserDetails(widget.uid);
  }

  @override
  void initState() {
    // TODO: implement initState
    _editProfileBloc = EditProfileBloc(userRepository: widget.userRepository);
    _editProfileBloc.add(LoadProfile(uid: widget.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state.isFailure) {
          showFailureTos(context);
        }
        if (state.isSubmitting) {
          showCircularProgress(context);
        }
        if (state.isSuccess) {
          Navigator.pop(context);
        }
      },
      bloc: _editProfileBloc,
      child: FutureBuilder(
          future: getDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  color: AppColors.scaffoldBackgroundColor,
                  child:  const Center(child: CircularProgressIndicator()));
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return BlocBuilder<EditProfileBloc, EditProfileState>(
              bloc: _editProfileBloc,
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Edit Profile", style: TextStyle(fontSize: 25)),
                    centerTitle: true,
                  ),
                  body: SingleChildScrollView(
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
                            child: Container(
                              height: size.width * 0.5,
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.25),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.red,
                                image: state.filePhoto.isNotEmpty
                                    ? DecorationImage(
                                        image: FileImage(File(state.filePhoto)),
                                        fit: BoxFit.cover,
                                      )
                                    : state.user.photoUrl.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(
                                                state.user.photoUrl),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                              ),
                              child: GestureDetector(
                                  child: state.filePhoto.isEmpty
                                      ? Icon(
                                          Icons.add_a_photo,
                                          size: size.width * 0.1,
                                          color: AppColors.white,
                                        )
                                      : null,
                                  onTap: () {
                                    _editProfileBloc.add(PhotoUrlChanged());
                                  }),
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          MyInputField(
                            onChanged: (value) {
                              _editProfileBloc.add(NameChanged(name: value));
                            },
                            label: user.name,
                            textInputType: TextInputType.name,
                            validator: (_) {
                              return state.user.name.isEmpty
                                  ? AppStrings.invalidName
                                  : null;
                            },
                          ),
                          SizedBox(height: size.height * 0.01),
                          MyInputField(
                            label: user.phone,
                            textInputType: TextInputType.phone,
                            onChanged: (value) => _editProfileBloc.add(
                              PhoneChanged(phone: value),
                            ),
                            validator: (_) => state.user.phone.isEmpty ||
                                    state.user.phone.length < 10
                                ? AppStrings.invalidPhone
                                : null,
                          ),
                          SizedBox(height: size.height * 0.01),
                          MyInputField(
                            label: user.country,
                            textInputType: TextInputType.name,
                            onChanged: (value) => _editProfileBloc.add(
                              CountryChanged(country: value),
                            ),
                            validator: (_) => state.user.country.isEmpty ||
                                state.user.country.length < 3
                                ? AppStrings.invalidCountry
                                : null,
                          ),
                          SizedBox(height: size.height * 0.01),
                          MyInputField(
                            label: user.state,
                            textInputType: TextInputType.name,
                            onChanged: (value) => _editProfileBloc.add(
                              StateChanged(state: value),
                            ),
                            validator: (_) => state.user.state.isEmpty ||
                                state.user.state.length < 3
                                ? AppStrings.invalidState
                                : null,
                          ),
                          SizedBox(height: size.height * 0.01),
                          MyInputField(
                            label: user.city,
                            textInputType: TextInputType.name,
                            onChanged: (value) => _editProfileBloc.add(
                              CityChanged(city: value),
                            ),
                            validator: (_) => state.user.city.isEmpty ||
                                state.user.city.length < 3
                                ? AppStrings.invalidCity
                                : null,
                          ),
                          SizedBox(height: size.height * 0.01),
                          Column(
                            children: [
                              Text(
                                AppStrings.isMarried,
                                style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      color: state.user.isMarried
                                          ?AppColors.white.withOpacity(0.1)
                                          : AppColors.transparent,
                                      child: TextButton(
                                        onPressed: () => _editProfileBloc.add(
                                          const IsMarriedChanged(isMarried: true),
                                        ),
                                        child: Text(
                                          AppStrings.yes,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: !state.user.isMarried
                                          ? AppColors.white.withOpacity(0.1)
                                          : AppColors.transparent,
                                      child: TextButton(
                                        onPressed: () => _editProfileBloc.add(
                                          const IsMarriedChanged(isMarried: false),
                                        ),
                                        child: Text(
                                          AppStrings.no,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          Column(
                            children: [
                              Text(
                                AppStrings.isOpenForRelationship,
                                style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      color: state.user.isOpen
                                          ? AppColors.white.withOpacity(0.1)
                                          : AppColors.transparent,
                                      child: TextButton(
                                        onPressed: () => _editProfileBloc.add(
                                          const IsOpenChanged(isOpen: true),
                                        ),
                                        child: Text(
                                          AppStrings.yes,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: !state.user.isOpen
                                          ? AppColors.white.withOpacity(0.1)
                                          : AppColors.transparent,
                                      child: TextButton(
                                        onPressed: () => _editProfileBloc.add(
                                          const IsOpenChanged(isOpen: false),
                                        ),
                                        child: Text(
                                          AppStrings.no,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  genderWidget(
                                      FontAwesomeIcons.venus,
                                      AppStrings.female,
                                      size,
                                      state.user.interestedIn, () {
                                    _editProfileBloc.add(InterestedInChanged(
                                        interestedIn: AppStrings.female));
                                  }),
                                  genderWidget(
                                      FontAwesomeIcons.mars,
                                      AppStrings.male,
                                      size,
                                      state.user.interestedIn, () {
                                    _editProfileBloc.add(InterestedInChanged(
                                        interestedIn: AppStrings.male));
                                  }),
                                  genderWidget(
                                      FontAwesomeIcons.marsAndVenus,
                                      AppStrings.other,
                                      size,
                                      state.user.interestedIn, () {
                                    _editProfileBloc.add(InterestedInChanged(
                                        interestedIn: AppStrings.other));
                                  }),
                                ],
                              ),
                              SizedBox(height: size.height * 0.05),
                              Container(
                                alignment: Alignment.center,
                                child: SimpleButton(
                                  onPressed: () {
                                      _editProfileBloc.add(UpdateProfile());
                                  },
                                  label: AppStrings.updateProfile,
                                  color: AppColors.white,
                                  textColor: AppColors.yellow,
                                  height: size.height * 0.06,
                                  width: size.width * 0.6,
                                ),
                              ),
                              SizedBox(height: size.height * 0.015),
                            ],
                          ),
                        ]),
                  )),
                );
              },
            );
          }),
    );
  }

  @override
  void dispose() {
    _editProfileBloc.close();
    super.dispose();
  }
}
