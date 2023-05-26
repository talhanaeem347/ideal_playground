part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {
  const AuthenticationEvent();

  List<Object> get props => [];
}
class AppStarted extends AuthenticationEvent {}
class LoggedIn extends AuthenticationEvent {}
class InitialComplete extends AuthenticationEvent{}
class LoggedOut extends AuthenticationEvent {}