import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ideal_playground/models/user.dart';


class MessageRepository {
  final FirebaseFirestore _fireStore;
  final CollectionReference _messageCollectionRef;

  MessageRepository(
      {FirebaseFirestore? fireStore, CollectionReference? messageCollectionRef})
      : _fireStore = fireStore ?? FirebaseFirestore.instance,
        _messageCollectionRef = messageCollectionRef ??
            FirebaseFirestore.instance.collection('chatRooms');

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

  Stream<QuerySnapshot> getChats({required String userId}) {
    return _messageCollectionRef
        .where("users.$userId", isEqualTo: true)
        // .orderBy('lastMessage.time', descending: true)
        .snapshots();
  }

  void deleteChat({required String chatRoomId}) async {
    await _messageCollectionRef.doc(chatRoomId).delete();
  }

  Future<UserModel> getUser({required String userId}) async {
    DocumentSnapshot snapshot =
        await _fireStore.collection('users').doc(userId).get();
    return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  void blockUser({required String userId, required String chatRoomId}) async {
    await _messageCollectionRef
        .doc(chatRoomId)
        .update({'users.$userId': false});
  }
}
