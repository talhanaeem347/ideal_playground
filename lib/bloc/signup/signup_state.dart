
part of 'signup_bloc.dart';


@immutable
class SignUpState {
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isConfirmPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isValidForm => isValidEmail && isValidPassword ;

  const SignUpState({required this.isValidEmail, required this.isValidPassword, required this.isConfirmPassword,required this.isSubmitting, required this.isSuccess, required this.isFailure});

  factory SignUpState.initial() {
    return const SignUpState(
      isValidEmail: false,
      isValidPassword: false,
      isConfirmPassword: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory SignUpState.empty() {
    return const SignUpState(
      isValidEmail: true,
      isValidPassword: true,
      isConfirmPassword: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory SignUpState.loading() {
    return const SignUpState(
      isValidEmail: true,
      isValidPassword: true,
      isConfirmPassword: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory SignUpState.success() {
    return const SignUpState(
      isValidEmail: true,
      isValidPassword: true,
      isConfirmPassword: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }
  factory SignUpState.failure() {
    return const SignUpState(
      isValidEmail: true,
      isValidPassword: true,
      isConfirmPassword: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  SignUpState update({
    bool? isValidEmail,
    bool? isValidPassword,
    bool? isConfirmPassword,
  }) {
    return copyWith(
      isValidEmail: isValidEmail,
      isValidPassword: isValidPassword,
      isConfirmPassword: isConfirmPassword,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignUpState copyWith({
    bool? isValidEmail,
    bool? isValidPassword,
    bool? isConfirmPassword,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return SignUpState(
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isConfirmPassword: isConfirmPassword ?? this.isConfirmPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}

// class LogInInitial extends SignUpState {}
