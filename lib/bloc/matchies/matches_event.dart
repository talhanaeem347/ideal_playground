part of 'matches_bloc.dart';

abstract class MatchesEvent extends Equatable {
  const MatchesEvent();

  @override
  List<Object> get props => [];
}

class MatchesLoadEvent extends MatchesEvent {
  final String userId;

  const MatchesLoadEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class MatchesOpenChatEvent extends MatchesEvent {
  final String currentUserId;
  final String selectedUserId;

  const MatchesOpenChatEvent(
      {required this.currentUserId, required this.selectedUserId});

  @override
  List<Object> get props => [currentUserId, selectedUserId];
}
class MatchesOpenCallEvent extends MatchesEvent {
final String currentUserId;
final String selectedUserId;

const MatchesOpenCallEvent(
{required this.currentUserId, required this.selectedUserId});

@override
List<Object> get props => [currentUserId, selectedUserId];
}

class MatchesDeleteUserEvent extends MatchesEvent {
  final String currentUserId;
  final String selectedUserId;

  const MatchesDeleteUserEvent(
      {required this.currentUserId, required this.selectedUserId});

  @override
  List<Object> get props => [currentUserId, selectedUserId];
}

class MatchesAcceptUserEvent extends MatchesEvent {
  final UserModel currentUser, selectedUser;

  const MatchesAcceptUserEvent(
      {required this.currentUser, required this.selectedUser});

  @override
  List<Object> get props => [currentUser, selectedUser];
}
