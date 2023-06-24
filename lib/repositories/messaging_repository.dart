import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ideal_playground/helpers/uuid_helper.dart';
import 'package:ideal_playground/models/chat_room_model.dart';
import 'package:ideal_playground/models/message.dart';
import 'package:ideal_playground/models/user.dart';


class MessagingRepository {
  final FirebaseFirestore _firestore;
  final CollectionReference _messageCollectionRef;
  final FirebaseStorage _firebaseStorage;


  MessagingRepository(
      {FirebaseStorage? firebaseStorage,
      FirebaseFirestore? firestore,
      CollectionReference? messageCollectionRef})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _messageCollectionRef = messageCollectionRef ??
            FirebaseFirestore.instance.collection('chatRooms'),
        _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  Future<String> getChatRoom({required String userId, required String matchedUserId}) async {
    QuerySnapshot snapshot = await _messageCollectionRef
        .where("users.$userId", isEqualTo: true)
        .where("users.$matchedUserId", isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final chatRoom = snapshot.docs[0].data() as Map<String, dynamic>;
      return chatRoom['chatRoomId'];
    } else {
      ChatRoomModel newChatRoom = ChatRoomModel(
          chatRoomId: assignId(),
          users: {userId: true, matchedUserId: true},
          lastMessage: Message(
            id: "",
            type: "text",
            content: "",
            senderId: "",
            isSeen: false,
            time: Timestamp.fromDate(DateTime.now()),
          ));
      await _messageCollectionRef
          .doc(newChatRoom.chatRoomId)
          .set(newChatRoom.toMap());
      return newChatRoom.chatRoomId;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      {required String chatRoomId}) {
    return _messageCollectionRef
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots();
  }

    Future<void> sendMessage(
        {required String chatRoomId,
        required String senderId,
        required String content,
        required String type}) async {
      Message message = Message(
        id: assignId(),
        senderId: senderId,
        content: content,
        type: type,
        time: Timestamp.fromDate(DateTime.now()),
        isSeen: false,
      );

      await _messageCollectionRef
          .doc(chatRoomId)
          .collection('messages')
          .doc(message.id)
          .set(
        message.toMap(),
      );
      await _messageCollectionRef.doc(chatRoomId).update({
        'lastMessage': message.toMap(),
      });
    }
    Future<String> uploadImage({required String filePath}) async {
      final TaskSnapshot uploadTask = await _firebaseStorage
          .ref()
          .child('chat_images/$assignId()')
          .putFile(File(filePath));

      return await uploadTask.ref.getDownloadURL();
    }


Future<void> updateMessageSeen(
      {required String chatRoomId, required String messageId}) async {
    await _messageCollectionRef
        .doc(chatRoomId)
        .collection('messages')
        .doc(messageId)
        .update({
      'isSeen': true,
    });

    await _messageCollectionRef.doc(chatRoomId).update({
      'lastMessage.isSeen': true,
    });
  }

  Future<void> deleteMessage(
      {required String chatRoomId, required String messageId}) async {
    await _messageCollectionRef
        .doc(chatRoomId)
        .collection('messages')
        .doc(messageId)
        .delete();
  }

  Future<void> deleteChatRoom({required String chatRoomId}) async {
    await _messageCollectionRef.doc(chatRoomId).delete();

  }

  Future<UserModel> getUser({required String userId}) async {
    DocumentSnapshot snapshot = await _firestore.collection('users').doc(userId).get();
    return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
  }

}
