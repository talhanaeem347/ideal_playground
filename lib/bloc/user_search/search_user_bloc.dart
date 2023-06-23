import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:ideal_playground/repositories/search_user_repository.dart';

part 'search_user_event.dart';

part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  final SearchUserRepository _searchUserRepository;

  SearchUserBloc({required SearchUserRepository searchUserRepository})
      : _searchUserRepository = searchUserRepository,
        super(SearchUserInitial()) {
    on<SearchUserFetchAll>(_onSearchUserFetchAll);
    on<SearchUserFetch>(_onSearchUserFetch);
  }

  FutureOr<void> _onSearchUserFetchAll(
      SearchUserFetchAll event, Emitter<SearchUserState> emit) {
    emit(SearchUserLoading());
    final users = _searchUserRepository.searchUserAll(event.userId);
    emit(SearchUserLoaded(users: users));
  }

  FutureOr<void> _onSearchUserFetch(SearchUserFetch event, Emitter<SearchUserState> emit) {
    final users = _searchUserRepository.searchUser(event.query);
    emit(SearchUserLoaded(users:users));
  }
}
