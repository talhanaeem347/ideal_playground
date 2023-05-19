
part of 'signup_bloc.dart';


@immutable
class SignUpState {
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isValidForm => isValidEmail && isValidPassword ;

  const SignUpState({required this.isValidEmail, required this.isValidPassword, required this.isSubmitting, required this.isSuccess, required this.isFailure});

  factory SignUpState.initial() {
    return const SignUpState(
      isValidEmail: false,
      isValidPassword: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory SignUpState.empty() {
    return const SignUpState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory SignUpState.loading() {
    return const SignUpState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory SignUpState.success() {
    return const SignUpState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }
  factory SignUpState.failure() {
    return const SignUpState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  SignUpState update({
    bool? isValidEmail,
    bool? isValidPassword,
  }) {
    return copyWith(
      isValidEmail: isValidEmail,
      isValidPassword: isValidPassword,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignUpState copyWith({
    bool? isValidEmail,
    bool? isValidPassword,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return SignUpState(
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}

// class LogInInitial extends SignUpState {}
