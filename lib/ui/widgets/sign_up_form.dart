import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/authentication/authentication_bloc.dart';
import 'package:ideal_playground/bloc/signup/signup_bloc.dart';
import 'package:ideal_playground/repositories/user_repository.dart';
import 'package:ideal_playground/ui/widgets/custom/my_input_field.dart';
import 'package:ideal_playground/ui/widgets/custom/simple_button.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

import 'custom/toses.dart';

class SignUpForm extends StatefulWidget {
  final UserRepository _userRepository;

  const SignUpForm({
    Key? key,
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  SignupBloc _signUpBloc = SignupBloc(userRepository: UserRepository());

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty;

  bool isSignUpButtonEnabled(SignUpState state) {
    return isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _signUpBloc = SignupBloc(userRepository: _userRepository);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _confirmPasswordController.addListener(_onConfirmPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener(
      bloc: _signUpBloc,
      listener: (BuildContext context, SignUpState state) {
        if (state.isFailure) {
          showFailureTos(context);
        }
        if (state.isSubmitting) {
          showCircularProgress(context);
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder(
        bloc: _signUpBloc,
        builder: (BuildContext context, SignUpState state) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              color: AppColors.scaffoldBackgroundColor,
              height: size.height * 0.65,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: size.height * 0.2,
                    width: size.width * 0.5,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo.jpg'),
                      ),
                    ),
                  ),
                  MyInputField(
                      controllerText: _emailController,
                      label: AppStrings.email,
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        return !state.isValidEmail
                            ? AppStrings.invalidEmail
                            : null;
                      }),
                  MyInputField(
                    controllerText: _passwordController,
                    label: AppStrings.password,
                    textInputType: TextInputType.visiblePassword,
                    isObscure: true,
                    validator: (value) {
                      return !state.isValidPassword
                          ? AppStrings.invalidPassword
                          : null;
                    },
                  ),
                  MyInputField(
                    controllerText: _confirmPasswordController,
                    label: AppStrings.confirmPassword,
                    textInputType: TextInputType.visiblePassword,
                    isObscure: true,
                    validator: (value) {
                      return !state.isConfirmPassword
                          ? AppStrings.passNoMatch
                          : null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SimpleButton(
                    onPressed: () {
                      if (state.isConfirmPassword &&
                          isSignUpButtonEnabled(state)) {
                        _onFormSubmitted(state);
                      }
                    },
                    label: AppStrings.signUp,
                    color: isSignUpButtonEnabled(state)
                        ? AppColors.white
                        : AppColors.white.withOpacity(0.5),
                    textColor: AppColors.yellow,
                    width: size.width * 0.5,
                    height: size.height * 0.08,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onEmailChanged() =>
      _signUpBloc.add(SignUpEmailChanged(email: _emailController.text));

  void _onPasswordChanged() => _signUpBloc
      .add(SignUpPasswordChanged(password: _passwordController.text));

  void _onConfirmPasswordChanged() =>
      _signUpBloc.add(SignUpConfirmPasswordChanged(
          confirmPassword: _confirmPasswordController.text,
          password: _passwordController.text));

  void _onFormSubmitted(SignUpState state) {
    _signUpBloc.add(SignUpWithEmailPasswordPressed(
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _signUpBloc.close();
    super.dispose();
  }
}
