import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ideal_playground/models/chat_room_model.dart';
import 'package:ideal_playground/models/message.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:ideal_playground/repositories/message_repository.dart';

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
    return UserModel.fromMap(user.data() as Map<String, dynamic>);
  }

  Future<void> removeMatch(
      {required String currentUserId, required String selectedUserId}) async {
     _fireStore
        .collection('users')
        .doc(currentUserId)
        .collection('matchedList')
        .doc(selectedUserId)
        .delete();
     _fireStore
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
      'name': selectedUser.name,
    });
    await _fireStore
        .collection('users')
        .doc(selectedUser.id)
        .collection('matchedList')
        .doc(currentUser.id)
        .set({
      'userId': currentUser.id,
      'photoUrl': currentUser.photoUrl,
      'name': currentUser.name,
    });
    return await deleteUser(
        currentUserId: currentUser.id, selectedUserId: selectedUser.id);
  }

  openCall(
      {required String currentUserId, required String selectedUserId}) async {
    await _fireStore
        .collection('users')
        .doc(currentUserId)
        .collection('calls')
        .doc(selectedUserId)
        .set({
      'userId': selectedUserId,
      'lastCall': '',
      'lastMessageTime': DateTime.now(),
    });
    await _fireStore
        .collection('users')
        .doc(selectedUserId)
        .collection('calls')
        .doc(currentUserId)
        .set({
      'userId': currentUserId,
      'lastCall': '',
      'lastMessageTime': DateTime.now(),
    });
  }
}
