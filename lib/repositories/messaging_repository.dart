import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:ideal_playground/models/chat_roam_model.dart';
import 'package:ideal_playground/models/message.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:uuid/uuid.dart';

class MessagingRepository {
  final FirebaseFirestore _firestore;
  final CollectionReference _messageCollectionRef;
  final FirebaseStorage _firebaseStorage;
  final uuid = const Uuid().v4();

  MessagingRepository(
      {FirebaseStorage? firebaseStorage,
      FirebaseFirestore? firestore,
      CollectionReference? messageCollectionRef})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _messageCollectionRef = messageCollectionRef ??
            FirebaseFirestore.instance.collection('chatRoams'),
        _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  Future<String> getChatRoam({required String userId, required String matchedUserId}) async {
    QuerySnapshot snapshot = await _messageCollectionRef
        .where("users.$userId", isEqualTo: true)
        .where("users.$matchedUserId", isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final chatRoam = snapshot.docs[0].data() as Map<String, dynamic>;
      return chatRoam['chatRoamId'];
    } else {
      ChatRoamModel newChatRoam = ChatRoamModel(
          chatRoamId: uuid,
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
          .doc(newChatRoam.chatRoamId)
          .set(newChatRoam.toMap());
      return newChatRoam.chatRoamId;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      {required String chatRoamId}) {
    return _messageCollectionRef
        .doc(chatRoamId)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots();
  }

  Future<void> sendMessage(
      {required String chatRoamId,
      required String senderId,
      required String content,
      required String type}) async {
    Message message = Message(
      id: uuid,
      senderId: senderId,
      content: content,
      type: type,
      time: Timestamp.fromDate(DateTime.now()),
      isSeen: false,
    );

    await _messageCollectionRef
        .doc(chatRoamId)
        .collection('messages')
        .doc(message.id)
        .set(
          message.toMap(),
        );
    await _messageCollectionRef.doc(chatRoamId).update({
      'lastMessage': message.toMap(),
    });

    Future<String> uploadImage({required String filePath}) async {
      final TaskSnapshot uploadTask = await _firebaseStorage
          .ref()
          .child('chat_images/$uuid')
          .putFile(File(filePath));

      return await uploadTask.ref.getDownloadURL();
    }
  }

Future<void> updateMessageSeen(
      {required String chatRoamId, required String messageId}) async {
    await _messageCollectionRef
        .doc(chatRoamId)
        .collection('messages')
        .doc(messageId)
        .update({
      'isSeen': true,
    });

    await _messageCollectionRef.doc(chatRoamId).update({
      'lastMessage.isSeen': true,
    });
  }

  Future<void> deleteMessage(
      {required String chatRoamId, required String messageId}) async {
    await _messageCollectionRef
        .doc(chatRoamId)
        .collection('messages')
        .doc(messageId)
        .delete();
  }

  Future<void> deleteChatRoam({required String chatRoamId}) async {
    await _messageCollectionRef.doc(chatRoamId).delete();

  }

  Future<UserModel> getUser({required String userId}) async {
    DocumentSnapshot snapshot = await _firestore.collection('users').doc(userId).get();
    return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
  }

}
