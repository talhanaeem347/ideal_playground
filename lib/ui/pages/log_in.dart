import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/login/log_in_bloc.dart';
import 'package:ideal_playground/repositories/user_repository.dart';
import 'package:ideal_playground/ui/pages/sign_up.dart';
import 'package:ideal_playground/ui/widgets/log_in_form.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class LogInPage extends StatefulWidget {
  final UserRepository _userRepository;

  const LogInPage({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  UserRepository get _userRepository => widget._userRepository;

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider<LogInBloc>(
        create: (context) => LogInBloc(userRepository: _userRepository),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  AppStrings.logInHere,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                LogInForm(userRepository: _userRepository),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            SignUpPage(userRepository: _userRepository)));
                  },
                  child: Text(
                    AppStrings.dontHaveAnAccount,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
