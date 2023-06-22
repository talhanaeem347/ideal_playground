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
    on<ProfileComplete>(_mapProfileCompleteToState);
    on<LoggedOut>(_mapAppLoggedOutToState);
  }

  Future<String> get _uid async => await _userRepository.getCurrentUserId();

  AuthenticationState get initialState => UnInitialized();

  void _mapAppStartedToState(event, emit) async {
    const Duration duration = Duration(seconds: 2);
    await Future.delayed(duration);
    try {
      final String uid = await _uid;
      final isLogIn = await _userRepository.isLoggedIn();
      if (isLogIn) {
        final isFirstTime = await _userRepository.isFirstTime(uid);
        if (isFirstTime == null) {
          emit(UnAuthenticated());
        } else if (isFirstTime) {
          emit(AuthenticatedButNotSet(uid));
        } else if (await _userRepository.userNotComplete(uid)) {
          emit(ProfileInComplete(uid));
        } else {
          emit(Authenticated(uid));
        }
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  void _mapAppLoggedInToState(event, emit) async {
    final uid = await _uid;
    try {
      final isFirstTime = await _userRepository.isFirstTime(uid);
      if (isFirstTime == null) {
        emit(UnAuthenticated());
      } else if (isFirstTime) {
        emit(AuthenticatedButNotSet(uid));
      } else if (await _userRepository.userNotComplete(uid)) {
        emit(ProfileInComplete(uid));
      } else {
        emit(Authenticated(uid));
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  void _mapAppLoggedOutToState(event, emit) async {
    emit(UnInitialized());
    await _userRepository.signOut();
    emit(UnAuthenticated());
  }

  void _mapAppInitialToState(event, emit) async {
    emit(ProfileInComplete(await _uid));
  }

  void _mapProfileCompleteToState(event, emit) async {
    emit(Authenticated(await _uid));
  }


}
