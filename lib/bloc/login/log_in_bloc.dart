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
// part 'log_in_event.dart';
// part 'log_in_state.dart';
//
// class LogInBloc extends Bloc<LogInEvent, LogInState> {
//   final UserRepository _userRepository;
//
//   LogInBloc({required UserRepository userRepository})
//       : assert(!userRepository.isNull),
//         _userRepository = userRepository,
//         super(LogInState.initial());
//
//   LogInState get initialState => LogInState.initial();
//
//   Stream<Transition<LogInEvent, LogInState>> transformEvents(
//     Stream<LogInEvent> events,
//     transitionFn,
//   ) {
//     final observableStream = events;
//     final nonDebounceStream = observableStream.where((event) {
//       return (event is! LogInEmailChanged && event is! LogInPasswordChanged);
//     });
//     final debounceStream = observableStream.where((event) {
//       return (event is LogInEmailChanged || event is LogInPasswordChanged);
//     }).debounceTime(const Duration(milliseconds: 300));
//     return Stream.eventTransformed(
//         nonDebounceStream.mergeWith([debounceStream]), transitionFn);
//   }
//
//   Stream<LogInState> mapEventToState(LogInEvent event) async* {
//     if (event is LogInEmailChanged) {
//       yield* _mapLogInEmailChangedToState(event.email);
//     } else if (event is LogInPasswordChanged) {
//       yield* _mapLogInPasswordChangedToState(event.password);
//     } else if (event is LogInWithEmailPasswordPressed) {
//       yield* _mapLogInWithEmailPasswordPressedToState(
//           event.email, event.password);
//     }
//   }
//
//   Stream<LogInState> _mapLogInEmailChangedToState(String email) async* {
//     yield state.update(isValidEmail: validator.email(email));
//   }
//
//   Stream<LogInState> _mapLogInPasswordChangedToState(String password) async* {
//     yield state.update(isValidPassword: validator.password(password));
//   }
//
//   Stream<LogInState> _mapLogInWithEmailPasswordPressedToState(
//       String email, String password) async* {
//     yield LogInState.loading();
//     try {
//       await _userRepository.signInWithEmail(email, password);
//       yield LogInState.success();
//     } catch (_) {
//       yield LogInState.failure();
//     }
//   }
// }

import 'dart:async';
import 'dart:js_interop';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ideal_playground/repositories/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/transformers.dart';
import 'package:regexed_validator/regexed_validator.dart';

part 'log_in_event.dart';

part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  final UserRepository _userRepository;

  LogInBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LogInState.initial()) {
    on<LogInEmailChanged>(_mapLogInEmailChangedToState);
    on<LogInPasswordChanged>(_mapLogInPasswordChangedToState);
    on<LogInWithEmailPasswordPressed>(_mapLogInWithEmailPasswordPressedToState);
  }

  LogInState get initialState => LogInState.initial();

  Stream<Transition<LogInEvent, LogInState>> transformEvents(
    Stream<LogInEvent> events,
    transitionFn,
  ) {
    final observableStream = events;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! LogInEmailChanged && event is! LogInPasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is LogInEmailChanged || event is LogInPasswordChanged);
    }).debounceTime(const Duration(milliseconds: 300));
    return Stream.eventTransformed(
        nonDebounceStream.mergeWith([debounceStream]), transitionFn);
  }

  void _mapLogInEmailChangedToState(event, emit) async {
    emit(state.update(isValidEmail: validator.email(event.email)));
  }

  void _mapLogInPasswordChangedToState(event, emit) async {
    emit(state.update(isValidPassword: validator.password(event.password)));
  }

  void _mapLogInWithEmailPasswordPressedToState(event, emit) async {
    emit(LogInState.loading());
    try {
      await _userRepository.signInWithEmail(event.email, event.password);
      emit(LogInState.success());
    } catch (_) {
      emit(LogInState.failure());
    }
  }
}
