part of 'messaging_bloc.dart';

abstract class MessagingEvent extends Equatable {
  const MessagingEvent();
  @override
  List<Object> get props => [];
}

class LoadChatRoom extends MessagingEvent {
  final String chatRoomId;

  const LoadChatRoom({required this.chatRoomId});
  @override
  List<Object> get props => [chatRoomId];
}

class SendMessage extends MessagingEvent{
  final String content;
  final String chatRoomId;
  final String senderId;
  final String matchId;
  final String type;


  const SendMessage({required this.content, required this.chatRoomId, required this.senderId,required this.matchId,required this.type});
  @override
  List<Object> get props => [content, chatRoomId, senderId,type];
}

class UpdateMessage extends MessagingEvent{
  final String messageId;
  final String chatRoomId;

  const UpdateMessage({required this.messageId, required this.chatRoomId});

  @override
  List<Object> get props => [messageId, chatRoomId];
}





