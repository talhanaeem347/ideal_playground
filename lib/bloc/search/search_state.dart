part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitialState extends SearchState {
  @override
  List<Object> get props => [];
}
class SearchLoadingState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchUserState extends SearchState {
  final UserModel user;
  final UserModel currentUser;
  const SearchUserState({required this.user, required this.currentUser});
  @override
  List<Object> get props => [user , currentUser];
}

class SearchSuccess extends SearchState {
  final List<UserModel> users;

  const SearchSuccess({required this.users});

  @override
  List<Object> get props => [users];
}
class SearchFailure extends SearchState {
  @override
  List<Object> get props => [];
}


