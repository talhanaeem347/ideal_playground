import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ideal_playground/models/user.dart';

class MatchRepository {
  final FirebaseFirestore _fireStore;

  MatchRepository({FirebaseFirestore? fireStore})
      : _fireStore = fireStore ?? FirebaseFirestore.instance;

  Stream<QuerySnapshot> getMatchedList({required String userId}) {
    return _fireStore
        .collection('users')
        .doc(userId)
        .collection('matchedList')
        .snapshots();
  }

  Stream<QuerySnapshot> getSelectedList({required String userId}) {
    return _fireStore
        .collection('users')
        .doc(userId)
        .collection('selectedList')
        .snapshots();
  }

  Future<UserModel> getUserDetails({required String userId}) async {
    final user = await _fireStore.collection('users').doc(userId).get();
    return UserModel.fromMap(user as Map<String, dynamic>);
  }

  Future openChat(
      {required String currentUserId, required String selectedUserId}) async {
    await _fireStore
        .collection('users')
        .doc(currentUserId)
        .collection('chats')
        .doc(selectedUserId)
        .set({
      'userId': selectedUserId,
      'lastMessage': '',
      'lastMessageTime': DateTime.now(),
    });
    await _fireStore
        .collection('users')
        .doc(selectedUserId)
        .collection('chats')
        .doc(currentUserId)
        .set({
      'userId': currentUserId,
      'lastMessage': '',
      'lastMessageTime': DateTime.now(),
    });
    await _fireStore
        .collection('users')
        .doc(currentUserId)
        .collection('matchedList')
        .doc(selectedUserId)
        .delete();
    await _fireStore
        .collection('users')
        .doc(selectedUserId)
        .collection('matchedList')
        .doc(currentUserId)
        .delete();
  }

  Future deleteUser(
      {required String currentUserId, required String selectedUserId}) async {
    await _fireStore
        .collection('users')
        .doc(currentUserId)
        .collection('selectedList')
        .doc(selectedUserId)
        .delete();
  }

  acceptUser({
    required UserModel currentUser,
    required UserModel selectedUser,
  }) async {
    await _fireStore
        .collection('users')
        .doc(currentUser.id)
        .collection('matchedList')
        .doc(selectedUser.id)
        .set({
      'userId': selectedUser.id,
      'photoUrl': selectedUser.photoUrl,
    });
    await _fireStore
        .collection('users')
        .doc(selectedUser.id)
        .collection('matchedList')
        .doc(currentUser.id)
        .set({
      'userId': currentUser.id,
      'photoUrl': currentUser.photoUrl,
    });
    return await deleteUser(
        currentUserId: currentUser.id, selectedUserId: selectedUser.id);
  }
}
