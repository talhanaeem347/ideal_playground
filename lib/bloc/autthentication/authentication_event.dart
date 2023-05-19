part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}
class AppStarted extends AuthenticationEvent {}
class LoggedIn extends AuthenticationEvent {
  // final String uid;
  // const LoggedIn(this.uid);
  // @override
  // List<Object> get props => [uid];
  // @override
  // String toString() => 'LoggedIn { uid: $uid }';
}
class LoggedOut extends AuthenticationEvent {}