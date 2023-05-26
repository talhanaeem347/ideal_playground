import 'package:ideal_playground/bloc/authentication/authentication_bloc.dart';
import 'package:ideal_playground/ui/widgets/custom/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/profile/profile_bloc.dart';
import 'package:ideal_playground/repositories/user_repository.dart';
import 'package:ideal_playground/ui/widgets/custom/my_input_field.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';
import 'package:regexed_validator/regexed_validator.dart';

class ProfileFormMor extends StatelessWidget {
  final UserRepository _userRepository;

  const ProfileFormMor({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  get _profileBloc => ProfileBloc(userRepository: _userRepository);

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
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      bloc: _profileBloc,
      child: BlocBuilder<ProfileBloc, ProfileState>(
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
                    MyInputField(
                      label: AppStrings.phone,
                      textInputType: TextInputType.phone,
                      onChanged: (value) => _profileBloc.add(
                        PhoneChanged(phone: value),
                      ),
                      validator: (_) =>
                          !validator.phone(state.user.phone.toString())
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
                      validator: (_) => state.user.country.isEmpty
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
                      validator: (_) => state.user.name.isEmpty
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
                      validator: (_) => state.user.city.isEmpty
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
                                color: !state.user.isMarried
                                    ? AppColors.transparent
                                    : AppColors.white.withOpacity(0.1),
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
                                color: state.user.isMarried
                                    ? AppColors.transparent
                                    : AppColors.white.withOpacity(0.1),
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
                                color: !state.user.isOpen
                                    ? AppColors.transparent
                                    : AppColors.white.withOpacity(0.1),
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
                                color: state.user.isOpen
                                    ? AppColors.transparent
                                    : AppColors.white.withOpacity(0.1),
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
                    Container(
                      alignment: Alignment.center,
                      child: SimpleButton(
                        onPressed: () {
                          if (state.endValid) {
                            _profileBloc.add( ProfileSubmitted(user: state.user));
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
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
