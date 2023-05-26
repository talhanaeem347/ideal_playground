// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:ideal_playground/repositories/user_repository.dart';
// import 'package:meta/meta.dart';
//
// part 'authentication_event.dart';
// part 'authentication_state.dart';
//
// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   final UserRepository _userRepository;
//
//   AuthenticationBloc(super.initialState,
//       {required UserRepository userRepository})
//         :_userRepository = userRepository;
//
//   AuthenticationState get initialState => UnInitialized();
//
//   Stream<AuthenticationState> mapEventToState(
//     AuthenticationEvent event,
//   ) async* {
//     if (event is AppStarted) {
//       yield* _mapAppStartedToState();
//     } else if (event is LoggedIn) {
//       yield* _mapAppLoggedInToState();
//     } else if (event is LoggedOut) {
//       yield UnAuthenticated();
//     }
//   }
//
//   Stream<AuthenticationState> _mapAppStartedToState() async* {
//     try {
//       final isLogIn = await _userRepository.isLoggedIn();
//       if (isLogIn) {
//         final uid = await _userRepository.getCurrentUser();
//         final isFirstTime = await _userRepository.isFirstTime(uid);
//         if (isFirstTime) {
//           yield AuthenticatedButNotSet(uid);
//         } else {
//           yield Authenticated(uid);
//         }
//       } else {
//         yield UnAuthenticated();
//       }
//     } catch (_) {
//       yield UnAuthenticated();
//     }
//   }
//
//   Stream<AuthenticationState> _mapAppLoggedInToState() async* {
//     final uid = await _userRepository.getCurrentUser();
//     final isFirstTime = await _userRepository.isFirstTime(uid);
//     if (isFirstTime) {
//       yield AuthenticatedButNotSet(uid);
//     } else {
//       yield Authenticated(uid);
//     }
//   }
// }
//

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ideal_playground/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UnInitialized()) {
    on<AppStarted>(_mapAppStartedToState);
    on<LoggedIn>(_mapAppLoggedInToState);
    on<InitialComplete>(_mapAppInitialToState);
    on<LoggedOut>(_mapAppLoggedOutToState);
  }

  Future<String> get uid async => await _userRepository.getCurrentUser();

  AuthenticationState get initialState => UnInitialized();

  void _mapAppStartedToState(event, emit) async {
    try {
      final isLogIn = await _userRepository.isLoggedIn();
      if (isLogIn) {
        final isFirstTime = await _userRepository.isFirstTime(await uid);
        if (!isFirstTime) {
          emit(AuthenticatedButNotSet(await uid));
        } else if (await _userRepository.userNotComplete(await uid)) {
          emit(ProfileInComplete(await uid));
        } else {
          emit(Authenticated(await uid));
        }
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  void _mapAppLoggedInToState(event, emit) async {
    try {
      final isFirstTime = await _userRepository.isFirstTime(await uid);
      if (isFirstTime) {
        emit(AuthenticatedButNotSet(await uid));
      } else if (await _userRepository.userNotComplete(await uid)) {
        emit(ProfileInComplete(await uid));
      } else {
        emit(Authenticated(await uid));
      }
    } catch (_) {
      emit(AuthenticatedButNotSet(await uid));
    }
  }

  void _mapAppLoggedOutToState(event, emit) async {
    await _userRepository.signOut();
    emit(UnAuthenticated());
  }

  void _mapAppInitialToState(event, emit) async {
    emit(ProfileInComplete(await uid));
  }
}
