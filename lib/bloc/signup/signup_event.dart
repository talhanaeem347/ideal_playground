part of 'signup_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  const SignUpEmailChanged({required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'SignUpEmailChanged { email :$email }';
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  const SignUpPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'SignUpPasswordChanged { password: $password }';
}

class SignUpSubmitted extends SignUpEvent {
  String email;
  String password;

  SignUpSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'SignUpSubmitted { email: $email, password: $password }';
}

class SignUpConfirmPasswordChanged extends SignUpEvent {
  final String confirmPassword;
  final String password;

  const SignUpConfirmPasswordChanged(
      {required this.confirmPassword, required this.password});

  @override
  List<Object> get props => [confirmPassword, password];

  @override
  String toString() =>
      'SignUpConfirmPasswordChanged { confirmPassword: $confirmPassword, password: $password } ';
}

class SignUpWithEmailPasswordPressed extends SignUpEvent {
  final String email;
  final String password;

  const SignUpWithEmailPasswordPressed(
      {required this.email, required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'SignUpWithEmailPasswordPressed { email: $email, password: $password  }';
}

class LogInWithGooglePressed extends SignUpEvent {
  @override
  String toString() => 'LogInWithGooglePressed';
}
