// import 'dart:async';
// import 'dart:js_interop';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:ideal_playground/repositories/user_repository.dart';
// import 'package:meta/meta.dart';
// import 'package:rxdart/streams.dart';
// import 'package:rxdart/transformers.dart';
// import 'package:regexed_validator/regexed_validator.dart';
//
// part 'signup_event.dart';
// part 'signup_state.dart';
//
// class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
//   final UserRepository _userRepository;
//
//   SignUpBloc({required UserRepository userRepository})
//       : assert(!userRepository.isNull),
//         _userRepository = userRepository,
//         super(SignUpState.initial());
//
//   SignUpState get initialState => SignUpState.initial();
//
//   Stream<Transition<SignUpEvent, SignUpState>> transformEvents(
//       Stream<SignUpEvent> events,
//       transitionFn,
//       ) {
//     final observableStream = events;
//     final nonDebounceStream = observableStream.where((event) {
//       return (event is! SignUpEmailChanged && event is! SignUpPasswordChanged);
//     });
//     final debounceStream = observableStream.where((event) {
//       return (event is SignUpEmailChanged || event is SignUpPasswordChanged);
//     }).debounceTime(const Duration(milliseconds: 300));
//     return Stream.eventTransformed(
//         nonDebounceStream.mergeWith([debounceStream]), transitionFn);
//   }
//
//   Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
//     if (event is SignUpEmailChanged) {
//       yield* _mapSignUpEmailChangedToState(event.email);
//     } else if (event is SignUpPasswordChanged) {
//       yield* _mapSignUpPasswordChangedToState(event.password);
//     } else if (event is SignUpWithEmailPasswordPressed) {
//       yield* _mapSignUpWithEmailPasswordPressedToState(
//           event.email, event.password);
//     }
//   }
//
//   Stream<SignUpState> _mapSignUpEmailChangedToState(String email) async* {
//     yield state.update(isValidEmail: validator.email(email));
//   }
//
//   Stream<SignUpState> _mapSignUpPasswordChangedToState(String password) async* {
//     yield state.update(isValidPassword: validator.password(password));
//   }
//
//   Stream<SignUpState> _mapSignUpWithEmailPasswordPressedToState(
//       String email, String password) async* {
//     yield SignUpState.loading();
//     try {
//       await _userRepository.signInWithEmail(email, password);
//       yield SignUpState.success();
//     } catch (_) {
//       yield SignUpState.failure();
//     }
//   }
// }

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ideal_playground/repositories/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/transformers.dart';
import 'package:regexed_validator/regexed_validator.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignupBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignUpState.initial()) {
    on<SignUpEmailChanged>(_mapSignUpEmailChangedToState);
    on<SignUpPasswordChanged>(_mapSignUpPasswordChangedToState);
    on<SignUpConfirmPasswordChanged>(_mapConfirmPasswordChangedToState);
    on<SignUpWithEmailPasswordPressed>(
        _mapSignUpWithEmailPasswordPressedToState);
  }

  SignUpState get initialState => SignUpState.initial();

  Stream<Transition<SignUpEvent, SignUpState>> transformEvents(
    Stream<SignUpEvent> events,
    transitionFn,
  ) {
    final observableStream = events;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! SignUpEmailChanged && event is! SignUpPasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is SignUpEmailChanged || event is SignUpPasswordChanged);
    }).debounceTime(const Duration(milliseconds: 300));
    return Stream.eventTransformed(
        nonDebounceStream.mergeWith([debounceStream]), transitionFn);
  }

  void _mapSignUpEmailChangedToState(event, emit) async {
    emit(state.update(isValidEmail: validator.email(event.email)));
  }

  void _mapSignUpPasswordChangedToState(event, emit) async {
    emit(state.update(isValidPassword: validator.password(event.password)));
  }
  void _mapConfirmPasswordChangedToState(event, emit) async {
    emit(state.update(isConfirmPassword: event.confirmPassword == event.password));
  }


  void _mapSignUpWithEmailPasswordPressedToState(event, emit) async {
    emit(SignUpState.loading());
    try {
      await _userRepository.signUpWithEmail(event.email, event.password);
      emit(SignUpState.success());
    } catch (_) {
      emit(SignUpState.failure());
    }
  }
}
