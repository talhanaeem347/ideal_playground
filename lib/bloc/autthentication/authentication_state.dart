part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class UnInitialized extends AuthenticationState {}
class Authenticated extends AuthenticationState {
  final String uid;
  const Authenticated(this.uid);
  @override
  List<Object> get props => [uid];
  @override
  String toString() => 'Authenticated { uid: $uid }';
}

class AuthenticatedButNotSet extends AuthenticationState {
  final String uid;
  const AuthenticatedButNotSet(this.uid);
  @override
  List<Object> get props => [uid];
}
class UnAuthenticated extends AuthenticationState {}
