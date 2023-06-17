import 'package:ideal_playground/models/message.dart';

class ChatRoamModel{
  String chatRoamId;
  Map<String,dynamic> users;
  Message lastMessage;

  ChatRoamModel({
    required this.chatRoamId,
    required this.users,
    required this.lastMessage
  });

  factory ChatRoamModel.fromMap(Map<String, dynamic> json) {
    return ChatRoamModel(
      chatRoamId: json['chatRoamId'],
      users: json['users'],
      lastMessage: Message.fromMap(json['lastMessage'])
    );
  }

  Map<String, dynamic> toMap() => {
    'chatRoamId': chatRoamId,
    'users': users,
    'lastMessage': lastMessage.toMap()
  };

}