part of 'matches_bloc.dart';

abstract class MatchesState extends Equatable {
  const MatchesState();
  @override
  List<Object> get props => [];
}

class MatchesLoading extends MatchesState {}

class MatchesLoaded extends MatchesState {
  final Stream<QuerySnapshot> matchedList;
  final Stream<QuerySnapshot> selectedList;

  const MatchesLoaded({required this.matchedList, required this.selectedList});

  @override
  List<Object> get props => [matchedList, selectedList];
}

class ChatOpenState extends MatchesState {
  final ChatRoomModel chatRoom;
  final String userId;
  const ChatOpenState({required this.chatRoom,required this.userId});
  @override
  List<Object> get props => [chatRoom];

}