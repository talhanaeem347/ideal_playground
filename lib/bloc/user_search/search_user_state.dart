part of 'search_user_bloc.dart';

abstract class SearchUserState extends Equatable {
  const SearchUserState();
  @override
  List<Object> get props => [];
}

class SearchUserInitial extends SearchUserState {}

class SearchUserLoading extends SearchUserState {}

class SearchUserLoaded extends SearchUserState {
  Stream<QuerySnapshot<Map<String, dynamic>>> users;

  SearchUserLoaded({required this.users});

  @override
  List<Object> get props => [users];
}


