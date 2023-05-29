part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchUserState extends SearchState {
  final UserModel user;
  final UserModel currentUser;

  const SearchUserState({required this.user, required this.currentUser});

  @override
  List<Object> get props => [user, currentUser];
}
