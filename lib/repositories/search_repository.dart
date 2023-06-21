import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ideal_playground/models/user.dart';

class SearchRepository {
  final FirebaseFirestore _fireStore;

  SearchRepository({FirebaseFirestore? fireStore})
      : _fireStore = fireStore ?? FirebaseFirestore.instance;

  Future<UserModel> chosenUser(
      {required String currentUserId,
      required String selectedUserId,
      required String name,
      required String photoUrl}) async {
    await _fireStore
        .collection('users')
        .doc(currentUserId)
        .collection('chosenList')
        .doc(selectedUserId)
        .set({});
    await _fireStore
        .collection('users')
        .doc(selectedUserId)
        .collection('chosenList')
        .doc(currentUserId)
        .set({});
    await _fireStore
        .collection('users')
        .doc(selectedUserId)
        .collection('selectedList')
        .doc(currentUserId)
        .set({'name': name, 'photoUrl': photoUrl});
    return await getUser(currentUserId);
  }

  Future<UserModel> passUser({
    required String currentUserId,
    required String selectedUserId,
  }) async {
    await _fireStore
        .collection('users')
        .doc(currentUserId)
        .collection('chosenList')
        .doc(selectedUserId)
        .set({});
    await _fireStore
        .collection('users')
        .doc(selectedUserId)
        .collection('chosenList')
        .doc(currentUserId)
        .set({});

    return await getUser(currentUserId);
  }

  Future<UserModel> getUserInterests(String userId) async {
    DocumentSnapshot snapshot =
        await _fireStore.collection('users').doc(userId).get();
    return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  Future<List<String>> getChosenList(String userId) async {
    List<String> chosenList = [];
    QuerySnapshot<Map<String, dynamic>> docs = await _fireStore
        .collection('users')
        .doc(userId)
        .collection('chosenList')
        .get();
    for (var doc in docs.docs) {
      if (doc.exists) {
        chosenList.add(doc.id);
      }
    }
    return chosenList;
  }

  Future<UserModel> getUser(String userId) async {
    final List<String> chosenList = await getChosenList(userId);
    final UserModel currentUser = await getUserInterests(userId);

    QuerySnapshot<Map<String, dynamic>> users =
        await _fireStore.collection('users').get();

    for (var doc in users.docs) {
      if (!chosenList.contains(doc.id) &&
          doc.id != userId &&
          currentUser.interestedIn == doc["gender"] &&
          currentUser.gender == doc["interestedIn"]) {
        return UserModel.fromMap(doc.data());
      }
    }

    return UserModel();
  }

  void choseUser({required String currentUserId, required String  selectedUserId}) {
     _fireStore
        .collection('users')
        .doc(currentUserId)
        .collection('chosenList')
        .doc(selectedUserId)
        .set({});
     _fireStore
        .collection('users')
        .doc(selectedUserId)
        .collection('chosenList')
        .doc(currentUserId)
        .set({});
  }

}
