part of 'messaging_bloc.dart';

abstract class MessagingEvent extends Equatable {
  const MessagingEvent();
  @override
  List<Object> get props => [];
}

class LoadChatRoam extends MessagingEvent {
  final String chatRoamId;

  const LoadChatRoam({required this.chatRoamId});
  @override
  List<Object> get props => [chatRoamId];
}

class SendMessage extends MessagingEvent{
  final String content;
  final String chatRoamId;
  final String senderId;
  final String type;


  const SendMessage({required this.content, required this.chatRoamId, required this.senderId,required this.type});
  @override
  List<Object> get props => [content, chatRoamId, senderId,type];
}




