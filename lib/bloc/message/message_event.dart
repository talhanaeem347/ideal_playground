part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();
  List<Object> get props => [];
}
class LoadChatsEvent extends MessageEvent {
  final String userId;
  const LoadChatsEvent({required this.userId});
  @override
  List<Object> get props => [userId];
}
class BlockUserEvent extends MessageEvent {
  final String userId;
  final String chatRoamId;
  const BlockUserEvent({required this.userId, required this.chatRoamId});
  @override
  List<Object> get props => [userId, chatRoamId];
}
// class SearchMatchEvent extends MessageEvent{
//   final String userId;
//   final String searchKey;
//   const SearchMatchEvent({required this.userId,required this.searchKey});
//
//   List<Object> get props =>[userId,searchKey];
// }
//
//
// class LoadMessagesEvent extends MessageEvent {
//   final String currentUserId;
//   final String selectedUserId;
//   const LoadMessagesEvent({required this.currentUserId, required this.selectedUserId});
//   @override
//   List<Object> get props => [currentUserId, selectedUserId];
// }
//
//
