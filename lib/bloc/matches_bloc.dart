import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:ideal_playground/repositories/match_repository.dart';

part 'matches_event.dart';

part 'matches_state.dart';

class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {
  final MatchRepository _matchRepository;

  MatchesBloc({required MatchRepository matchRepository})
      : _matchRepository = matchRepository,
        super(MatchesLoading()) {
    on<MatchesEvent>(_mapEventToState);
  }

  Stream<MatchesState> _mapEventToState(
      MatchesEvent event, Emitter<MatchesState> emit) async* {
    if (event is MatchesLoadEvent) {
      yield* _mapMatchesLoadEventToState(event, emit);
    } else if (event is MatchesOpenChatEvent) {
      yield* _mapMatchesOpenChatEventToState(event, emit);
    } else if (event is MatchesDeleteUserEvent) {
      yield* _mapMatchesDeleteUserEventToState(event, emit);
    } else if (event is MatchesAcceptUserEvent) {
      yield* _mapMatchesAcceptUserEventToState(event, emit);
    }
  }

  Stream<MatchesState> _mapMatchesLoadEventToState(
      MatchesLoadEvent event, Emitter<MatchesState> emit) async* {
    yield  MatchesLoading();

    final matchedList = _matchRepository.getMatchedList(userId: event.userId);
    final selectedList = _matchRepository.getSelectedList(userId: event.userId);
     yield MatchesLoad(matchedList: matchedList, selectedList: selectedList);
  }
  Stream<MatchesState> _mapMatchesOpenChatEventToState(
      MatchesOpenChatEvent event, Emitter<MatchesState> emit) async* {
    yield  MatchesLoading();

    await _matchRepository.openChat(
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId);
  }
Stream<MatchesState> _mapMatchesDeleteUserEventToState(
      MatchesDeleteUserEvent event, Emitter<MatchesState> emit) async* {
    yield  MatchesLoading();

    await _matchRepository.deleteUser(
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId);
  }
Stream<MatchesState> _mapMatchesAcceptUserEventToState(
      MatchesAcceptUserEvent event, Emitter<MatchesState> emit) async* {
    yield  MatchesLoading();

    await _matchRepository.acceptUser(
        currentUser: event.currentUser,
        selectedUser: event.selectedUser);
  }

}
