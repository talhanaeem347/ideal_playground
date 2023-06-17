part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();
  List<Object> get props => [];
}
abstract class ChatRoamState extends MessageState {
  const ChatRoamState();
  List<Object> get props => [];
}
abstract class SearchState extends MessageState{
  const SearchState();
  List<Object> get props => [];
}

class ChatRoamInitial extends ChatRoamState {}
class ChatRoamLoading extends ChatRoamState {}
class ChatRoamError extends ChatRoamState {
  final String message;
  const ChatRoamError(this.message);
  @override
  List<Object> get props => [message];
}

class ChatRoamLoaded extends ChatRoamState {
  final ChatRoamModel chatRoam;
  const ChatRoamLoaded(this.chatRoam);
  @override
  List<Object> get props => [chatRoam];
}

class ChatRoamsLoaded extends MessageState {
  final Stream<QuerySnapshot> chatRoams;
  const ChatRoamsLoaded({required this.chatRoams});
  @override
  List<Object> get props => [chatRoams];
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
