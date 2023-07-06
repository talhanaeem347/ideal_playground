part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();
}

class LoadUserProfile extends UserProfileEvent {
  final String userId;
  const LoadUserProfile({required this.userId});
  @override
  List<Object> get props => [userId];
}

class EditProfile extends UserProfileEvent {
  final String userId;
  const EditProfile({required this.userId});
  @override
  List<Object> get props => [userId];
}

