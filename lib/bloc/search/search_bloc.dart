import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:ideal_playground/repositories/search_repository.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository _searchRepository;

  SearchBloc({required SearchRepository searchRepository})
      : _searchRepository = searchRepository,
        super(SearchInitialState()) {
    on<SelectUserEvent>(_mapSelectUserEventToState);
    on<PassUserEvent>(_mapPassEventToState);
    on<LoadUserEvent>(_mapLoadUserEventToState);
  }



  void _mapSelectUserEventToState(event, emit) async {
    emit(SearchLoadingState());
    final user = await _searchRepository.chosenUser(
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId,
        name: event.name,
        photoUrl: event.photoUrl);
    final currentUser =
        await _searchRepository.getUserInterests(event.currentUserId);
    emit(SearchUserState(user: user, currentUser: currentUser));
  }

  void _mapPassEventToState(event, emit) async {
    emit(SearchLoadingState());
    final user = await _searchRepository.passUser(
      currentUserId: event.currentUserId,
      selectedUserId: event.selectedUserId,
    );
    final currentUser =
        await _searchRepository.getUserInterests(event.currentUserId);
    emit(SearchUserState(user: user, currentUser: currentUser));
  }

  void _mapLoadUserEventToState(event, emit) async {
    emit(SearchLoadingState());
    final user = await _searchRepository.getUser(event.userId);
    final currentUser =
        await _searchRepository.getUserInterests(event.userId);
    emit(SearchUserState(user: user, currentUser: currentUser));
  }
}
