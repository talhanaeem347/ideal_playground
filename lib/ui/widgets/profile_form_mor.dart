import 'package:ideal_playground/bloc/authentication/authentication_bloc.dart';
import 'package:ideal_playground/ui/widgets/custom/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/profile/profile_bloc.dart';
import 'package:ideal_playground/repositories/user_repository.dart';
import 'package:ideal_playground/ui/widgets/custom/my_input_field.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

import 'custom/toses.dart';

class ProfileFormMor extends StatefulWidget {
  final UserRepository _userRepository;

  const ProfileFormMor({required UserRepository userRepository, Key? key})
      : _userRepository = userRepository,
        super(key: key);

  @override
  State<ProfileFormMor> createState() => _ProfileFormMorState();
}

class _ProfileFormMorState extends State<ProfileFormMor> {
  late ProfileBloc _profileBloc;

  UserRepository get _userRepository => widget._userRepository;



  @override
  void initState() {
    super.initState();
    _profileBloc = ProfileBloc(userRepository: _userRepository);
    _userRepository.getCurrentUserId().then((uid) {
      _profileBloc.add(ProfileLoad(userId: uid));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.isFailure) {
          showFailureTos(context);
        }
        if (state.isSubmitting) {
          showCircularProgress(context);
          }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(ProfileComplete());
        }
      },
      bloc: _profileBloc,
      child: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: _profileBloc,
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                color: AppColors.scaffoldBackgroundColor,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.01),
                    MyInputField(
                      label: AppStrings.phone,
                      textInputType: TextInputType.phone,
                      onChanged: (value) => _profileBloc.add(
                        PhoneChanged(phone: value),
                      ),
                      validator: (_) => state.user.phone.isEmpty ||
                              state.user.phone.length < 10
                          ? AppStrings.invalidPhone
                          : null,
                    ),
                    SizedBox(height: size.height * 0.01),
                    MyInputField(
                      label: AppStrings.country,
                      textInputType: TextInputType.name,
                      onChanged: (value) => _profileBloc.add(
                        CountryChanged(country: value),
                      ),
                      validator: (_) => state.user.country.isEmpty ||
                              state.user.country.length < 3
                          ? AppStrings.invalidCountry
                          : null,
                    ),
                    SizedBox(height: size.height * 0.01),
                    MyInputField(
                      label: AppStrings.state,
                      textInputType: TextInputType.name,
                      onChanged: (value) => _profileBloc.add(
                        StateChanged(state: value),
                      ),
                      validator: (_) => state.user.state.isEmpty ||
                              state.user.state.length < 3
                          ? AppStrings.invalidState
                          : null,
                    ),
                    SizedBox(height: size.height * 0.01),
                    MyInputField(
                      label: AppStrings.city,
                      textInputType: TextInputType.name,
                      onChanged: (value) => _profileBloc.add(
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
                                  onPressed: () => _profileBloc.add(
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
                                  onPressed: () => _profileBloc.add(
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
                                  onPressed: () => _profileBloc.add(
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
                                  onPressed: () => _profileBloc.add(
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
                    Container(
                      alignment: Alignment.center,
                      child: SimpleButton(
                        onPressed: () {
                          if (state.endValid)
                          {
                            _profileBloc
                                .add(ProfileSubmitted(user: state.user));
                          }
                        },
                        label: "Done",
                        color: state.endValid
                            ? AppColors.white
                            : Colors.white.withOpacity(0.5),
                        textColor: AppColors.yellow,
                        height: size.height * 0.06,
                        width: size.width * 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
