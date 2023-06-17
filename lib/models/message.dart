import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String id;
  String senderId;
  bool isSeen;
  String content;
  Timestamp time;
  String type;

  Message({
    required this.id,
    required this.senderId,
    required this.isSeen,
    required this.content,
    required this.time,
    required this.type
  });

  factory Message.fromMap(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      senderId: json['senderId'],
      isSeen: json['isSeen'],
      content: json['content'],
      time: json['time'],
      type: json['type']
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'senderId': senderId,
    'isSeen': isSeen,
    'content': content,
    'time': time,
    'type': type
  };
}