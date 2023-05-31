import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ideal_playground/models/user.dart';
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
    emit(state.update(
        isConfirmPassword: event.confirmPassword == event.password));
  }

  void _mapSignUpWithEmailPasswordPressedToState(event, emit) async {
    emit(SignUpState.loading());
    try {
      await _userRepository.signUpWithEmail(event.email, event.password);
      final user = await _userRepository.getCurrentUser();
      _userRepository.createProfile(
          user.uid,
          UserModel(
            id: user.uid,
            email: user.email!,
          ).toMap());
      emit(SignUpState.success());
    } catch (_) {
      emit(SignUpState.failure());
    }
  }
}
