import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/authentication/authentication_bloc.dart';
import 'package:ideal_playground/bloc/bloc_delegate.dart';
import 'package:ideal_playground/repositories/user_repository.dart';
import 'package:ideal_playground/ui/pages/log_in.dart';
import 'package:ideal_playground/ui/pages/profile.dart';
import 'package:ideal_playground/ui/pages/splash.dart';
import 'package:ideal_playground/ui/widgets/tabs.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';
import 'firebase_options.dart';
import 'helpers/location_permetion.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) =>
          AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
      child: MyApp(userRepository: userRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;

  const MyApp({required UserRepository userRepository, super.key})
      : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: ThemeData(
        primarySwatch: AppColors.primarySwatch,
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is UnInitialized) {
            return const Splash();
          } else if (state is UnAuthenticated) {
            return LogInPage(userRepository: _userRepository);
          } else if (state is AuthenticatedButNotSet) {
            return Profile(userRepository: _userRepository);
          } else if (state is ProfileInComplete) {
            return Profile(userRepository: _userRepository);
          } else if (state is Authenticated) {
            LocationPermissionHelper.checkPermission();
            return Tabs(userId: state.uid);
          } else {
            return const Splash();
          }
        },
      ),
    );
  }
}
