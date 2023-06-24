part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();
  List<Object> get props => [];
}
abstract class ChatRoomState extends MessageState {
  const ChatRoomState();
  List<Object> get props => [];
}
abstract class SearchState extends MessageState{
  const SearchState();
  List<Object> get props => [];
}

class ChatRoomInitial extends ChatRoomState {}
class ChatRoomLoading extends ChatRoomState {}
class ChatRoomError extends ChatRoomState {
  final String message;
  const ChatRoomError(this.message);
  @override
  List<Object> get props => [message];
}

class ChatRoomLoaded extends ChatRoomState {
  final ChatRoomModel chatRoom;
  const ChatRoomLoaded(this.chatRoom);
  @override
  List<Object> get props => [chatRoom];
}

class ChatRoomsLoaded extends MessageState {
  final Stream<QuerySnapshot> chatRooms;
  const ChatRoomsLoaded({required this.chatRooms});
  @override
  List<Object> get props => [chatRooms];
}

class MessageInitial extends MessageState {}

class ChatsloadingState extends MessageState {}

class ChatsLoadedState extends MessageState {
  final Stream<QuerySnapshot> chats;
  const ChatsLoadedState({required this.chats});
  @override
  List<Object> get props => [chats];
}





// class SearchStateLoading extends SearchState{}
//
// class SearchStateLoaded extends MessageState{
//   Stream<QuerySnapshot<Map<String,dynamic>>> matches;
//   SearchStateLoaded({required this.matches});
// }
// class MessageLoaded extends MessageState {
//   final Stream<QuerySnapshot> messages;
//   const MessageLoaded(this.messages);
//   @override
//   List<Object> get props => [messages];
// }
//
// class LoadingMessage extends MessageState {}
// class MessageError extends MessageState {
//   final String message;
//   const MessageError(this.message);
//   @override
//   List<Object> get props => [message];
// }
//
// class MessageSent extends MessageState {}
//
// class MessageUpdated extends MessageState {}
//
