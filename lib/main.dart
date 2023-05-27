import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/authentication/authentication_bloc.dart';
import 'package:ideal_playground/bloc/bloc_delegate.dart';
import 'package:ideal_playground/repositories/user_repository.dart';
import 'package:ideal_playground/ui/pages/home.dart';
import 'package:ideal_playground/ui/pages/splash.dart';
import 'package:ideal_playground/ui/widgets/tabs.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final  UserRepository _userRepository = UserRepository();
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc =
        AuthenticationBloc( userRepository: _userRepository);
      _authenticationBloc.add(AppStarted());

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => _authenticationBloc,
      child: MaterialApp(
        title: AppStrings.appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,

        ),
        home: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (context, state) {
            if (state is UnInitialized) {
              return const Splash();
            } else if (state is Authenticated) {
              return const HomePage();
            } else if (state is UnAuthenticated) {
              return const Tabs();
            } else if (state is AuthenticatedButNotSet) {
              return const Text("AuthenticatedButNotSet");
            } else {
              return const Splash();
            }
          },
        )
      ),
      );
  }
}

