import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:ideal_playground/models/chat_roam_model.dart';
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

  void _mapEventToState(
      MatchesEvent event, Emitter<MatchesState> emit)  {
    if (event is MatchesLoadEvent) {
      _mapMatchesLoadEventToState(event, emit);
    } else if (event is MatchesOpenChatEvent) {
      _mapMatchesOpenChatEventToState(event, emit);
    } else if (event is MatchesDeleteUserEvent) {
      _mapMatchesDeleteUserEventToState(event, emit);
    } else if (event is MatchesAcceptUserEvent) {
      _mapMatchesAcceptUserEventToState(event, emit);
    }else if (event is MatchesOpenCallEvent) {
      _mapMatchesOpenCallEventToState(event, emit);
    }
  }

  void _mapMatchesLoadEventToState(
      MatchesLoadEvent event, Emitter<MatchesState> emit) {
    emit(MatchesLoading());
    final matchedList = _matchRepository.getMatchedList(userId: event.userId);
    final selectedList = _matchRepository.getSelectedList(userId: event.userId);
    emit(MatchesLoaded(matchedList: matchedList, selectedList: selectedList));
  }

  void _mapMatchesOpenChatEventToState(
      MatchesOpenChatEvent event, Emitter<MatchesState> emit) async {
    emit(MatchesLoading());

    await _matchRepository.removeMatch(
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId).then((chatRoam){

    });
  }

  void _mapMatchesDeleteUserEventToState(
      MatchesDeleteUserEvent event, Emitter<MatchesState> emit) async {
    emit(MatchesLoading());

    await _matchRepository.deleteUser(
        currentUserId: event.currentUserId,
        selectedUserId: event.selectedUserId);

  }

  void _mapMatchesAcceptUserEventToState(
      MatchesAcceptUserEvent event, Emitter<MatchesState> emit) async {
    emit(MatchesLoading());

    await _matchRepository.acceptUser(
        currentUser: event.currentUser, selectedUser: event.selectedUser);
  }

  void _mapMatchesOpenCallEventToState(MatchesOpenCallEvent event, Emitter<MatchesState> emit) {
    emit(MatchesLoading());
    _matchRepository.openCall(currentUserId: event.currentUserId, selectedUserId: event.selectedUserId);

  }
}
