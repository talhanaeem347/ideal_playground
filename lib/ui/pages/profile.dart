import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/authentication/authentication_bloc.dart';
import 'package:ideal_playground/bloc/profile/profile_bloc.dart';
import 'package:ideal_playground/repositories/user_repository.dart';
import 'package:ideal_playground/ui/widgets/profile_form.dart';
import 'package:ideal_playground/ui/widgets/profile_form_mor.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class Profile extends StatelessWidget {
  final UserRepository _userRepository;

  const Profile({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider<ProfileBloc>(
        create: (context) => ProfileBloc(userRepository: _userRepository),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  AppStrings.profile,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
              BlocProvider.of<AuthenticationBloc>(context).state is AuthenticatedButNotSet ?
                ProfileForm(userRepository: _userRepository) :
                ProfileFormMor(userRepository: _userRepository),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
