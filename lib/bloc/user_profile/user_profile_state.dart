part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();
}

class UserProfileInitial extends UserProfileState {
  @override
  List<Object> get props => [];
}

class UserProfileLoading extends UserProfileState {
  @override
  List<Object> get props => [];
}

class UserProfileLoaded extends UserProfileState {
  final UserModel user;
  const UserProfileLoaded({required this.user});
  @override
  List<Object> get props => [user];
}

class UpdateProfile extends UserProfileState {
  final UserModel user;
  const UpdateProfile({required this.user});
  @override
  List<Object> get props => [user];
}

class UserProfileError extends UserProfileState {
  final String message;
  const UserProfileError({required this.message});
  @override
  List<Object> get props => [message];
}
