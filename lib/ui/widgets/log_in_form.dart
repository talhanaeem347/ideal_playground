import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/authentication/authentication_bloc.dart';
import 'package:ideal_playground/bloc/login/log_in_bloc.dart';
import 'package:ideal_playground/repositories/user_repository.dart';
import 'package:ideal_playground/ui/widgets/custom/my_input_field.dart';
import 'package:ideal_playground/ui/widgets/custom/simple_button.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class LogInForm extends StatefulWidget {
  final UserRepository _userRepository;

  const LogInForm({
    Key? key,
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(key: key);

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late LogInBloc _logInBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LogInState state) {
    return isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _logInBloc = LogInBloc(userRepository: _userRepository);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener(
      bloc: _logInBloc,
      listener: (BuildContext context, LogInState state) {
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
                      Text(AppStrings.invalidEmailAndPasswordCombination),
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
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.loggingIn),
                      const CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          // Navigator.of(context).pop();
        }
      },
      child: BlocBuilder(
        bloc: _logInBloc,
        builder: (BuildContext context, LogInState state) {
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
                  SizedBox(height: size.height * 0.05),
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
                  const SizedBox(height: 20),
                  SimpleButton(
                    onPressed: () {
                      if (state.isValidEmail && state.isValidPassword && isLoginButtonEnabled(state)) {
                        _onFormSubmitted();
                      }
                    },
                    label: AppStrings.logIn,
                    color: isLoginButtonEnabled(state)
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
      _logInBloc.add(LogInEmailChanged(email: _emailController.text));

  void _onPasswordChanged() =>
      _logInBloc.add(LogInPasswordChanged(password: _passwordController.text));

  void _onFormSubmitted() {
    _logInBloc.add(LogInWithEmailPasswordPressed(
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _logInBloc.close();
    super.dispose();
  }
}
