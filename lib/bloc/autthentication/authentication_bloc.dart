import 'dart:async';
import 'dart:js_interop';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ideal_playground/repositories/user_repository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc(super.initialState,
      {required UserRepository userRepository})
      : assert(!userRepository.isNull),
        _userRepository = userRepository;

  AuthenticationState get initialState => UnInitialized();

  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapAppLoggedInToState();
    } else if (event is LoggedOut) {
      yield UnAuthenticated();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isLogIn = await _userRepository.isLoggedIn();
      if (isLogIn) {
        final uid = await _userRepository.getCurrentUser();
        final isFirstTime = await _userRepository.isFirstTime(uid);
        if (isFirstTime) {
          yield AuthenticatedButNotSet(uid);
        } else {
          yield Authenticated(uid);
        }
      } else {
        yield UnAuthenticated();
      }
    } catch (_) {
      yield UnAuthenticated();
    }
  }

  Stream<AuthenticationState> _mapAppLoggedInToState() async* {
    final uid = await _userRepository.getCurrentUser();
    final isFirstTime = await _userRepository.isFirstTime(uid);
    if (isFirstTime) {
      yield AuthenticatedButNotSet(uid);
    } else {
      yield Authenticated(uid);
    }
  }
}
