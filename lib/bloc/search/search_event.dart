part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class LoadUserEvent extends SearchEvent {
  final String userId;

  const LoadUserEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class SelectUserEvent extends SearchEvent {
  final String currentUserId;
  final String selectedUserId;
  final String name;
  final String photoUrl;

  const SelectUserEvent({required this.currentUserId, required this.selectedUserId, required this.name, required this.photoUrl});

  @override
  List<Object> get props => [currentUserId, selectedUserId, name, photoUrl];
}
class PassUserEvent extends SearchEvent {
  final String currentUserId;
  final String selectedUserId;
  final String name;
  final String photoUrl;

  const PassUserEvent({required this.currentUserId, required this.selectedUserId, required this.name, required this.photoUrl});

  @override
  List<Object> get props => [currentUserId, selectedUserId, name, photoUrl];
}
