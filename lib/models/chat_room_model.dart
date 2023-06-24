import 'package:ideal_playground/models/message.dart';

class ChatRoomModel{
  String chatRoomId;
  Map<String,dynamic> users;
  Message lastMessage;

  ChatRoomModel({
    required this.chatRoomId,
    required this.users,
    required this.lastMessage
  });

  factory ChatRoomModel.fromMap(Map<String, dynamic> json) {
    return ChatRoomModel(
      chatRoomId: json['chatRoomId'],
      users: json['users'],
      lastMessage: Message.fromMap(json['lastMessage'])
    );
  }

  Map<String, dynamic> toMap() => {
    'chatRoomId': chatRoomId,
    'users': users,
    'lastMessage': lastMessage.toMap()
  };

}