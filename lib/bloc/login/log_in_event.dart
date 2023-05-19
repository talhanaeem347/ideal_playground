part of 'log_in_bloc.dart';

@immutable
abstract class LogInEvent extends Equatable {
  const LogInEvent();

  @override
  List<Object> get props => [];
}

class LogInEmailChanged extends LogInEvent {
  final String email;

  const LogInEmailChanged({required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'LogInEmailChanged { email :$email }';
}

class LogInPasswordChanged extends LogInEvent {
  final String password;

  const LogInPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'LogInPasswordChanged { password: $password }';
}

class LogInSubmitted extends LogInEvent {
  String email;
  String password;
  LogInSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'LogInSubmitted { email: $email, password: $password }';

}

class LogInWithEmailPasswordPressed extends LogInEvent {
  final String email;
  final String password;

  const LogInWithEmailPasswordPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'LogInWithEmailPasswordPressed { email: $email, password: $password }';
}
class LogInWithGooglePressed extends LogInEvent {
  @override
  String toString() => 'LogInWithGooglePressed';
}