import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ideal_playground/models/chat_roam_model.dart';
import 'package:ideal_playground/models/message.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class MessageRepository {
  final FirebaseFirestore _fireStore;
  final CollectionReference _messageCollectionRef;

  MessageRepository(
      {FirebaseFirestore? fireStore, CollectionReference? messageCollectionRef})
      : _fireStore = fireStore ?? FirebaseFirestore.instance,
        _messageCollectionRef = messageCollectionRef ??
            FirebaseFirestore.instance.collection('chats');

  Stream<QuerySnapshot<Map<String, dynamic>>> getMatches(
      {required String userId, String? searchKey}) {
    if (searchKey == null || searchKey.isEmpty) {
      return _fireStore
          .collection('users')
          .doc(userId)
          .collection('matchedList')
          .snapshots();
    }
    return _fireStore
        .collection('users')
        .doc(userId)
        .collection('matchedList')
        .where('name', isEqualTo: searchKey)
        .snapshots();
  }

  Future<ChatRoamModel> openChatRoam(userId, matchedUserId) async {
    QuerySnapshot snapshot = await _fireStore
        .collection('chatRoams')
        .where("users.$userId", isEqualTo: true)
        .where("users.$matchedUserId", isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final chatRoam = snapshot.docs[0].data();
      return ChatRoamModel.fromMap(chatRoam as Map<String, dynamic>);
    } else {
      ChatRoamModel newChatRoam = ChatRoamModel(
          chatRoamId: uuid.v1(),
          users: {userId: true, matchedUserId: true},
          lastMessage: Message(
            id: "",
            type: "text",
            content: "",
            senderId: "",
            isSeen: false,
            time: Timestamp.fromDate(DateTime.now()),
          ));
      await _fireStore
          .collection('chatRoams')
          .doc(newChatRoam.chatRoamId)
          .set(newChatRoam.toMap());
      return newChatRoam;
    }
  }

  Stream<QuerySnapshot> getChats({required String userId}) {
    return _fireStore
        .collection('chatRoams')
        .where("users.$userId", isEqualTo: true)
        .orderBy('time', descending: true)
        .snapshots();
  }

  void deleteChat({required String chatRoamId}) async {
    await _fireStore.collection('chatRoams').doc(chatRoamId).delete();
  }

  Future<UserModel> getUser({required String userId}) async {
    DocumentSnapshot snapshot =
        await _fireStore.collection('users').doc(userId).get();
    return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
  }
}
