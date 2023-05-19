part of 'log_in_bloc.dart';

@immutable
class LogInState {
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isValidForm => isValidEmail && isValidPassword ;

  const LogInState({required this.isValidEmail, required this.isValidPassword, required this.isSubmitting, required this.isSuccess, required this.isFailure});

  factory LogInState.initial() {
    return const LogInState(
      isValidEmail: false,
      isValidPassword: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory LogInState.empty() {
    return const LogInState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory LogInState.loading() {
    return const LogInState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory LogInState.success() {
    return const LogInState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }
  factory LogInState.failure() {
    return const LogInState(
      isValidEmail: true,
      isValidPassword: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  LogInState update({
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

  LogInState copyWith({
    bool? isValidEmail,
    bool? isValidPassword,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return LogInState(
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}

// class LogInInitial extends LogInState {}
