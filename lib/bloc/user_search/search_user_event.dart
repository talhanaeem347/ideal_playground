part of 'search_user_bloc.dart';

abstract class SearchUserEvent extends Equatable {
  const SearchUserEvent();
  @override
  List<Object> get props => [];
}

class SearchUserFetchAll extends SearchUserEvent {
  final String userId;

  const SearchUserFetchAll({required this.userId});

  @override
  List<Object> get props => [userId];
}

class SearchUserFetch extends SearchUserEvent {
  final String query;

  const SearchUserFetch({required this.query});

  @override
  List<Object> get props => [query];
}

class SearchUserClear extends SearchUserEvent {}


