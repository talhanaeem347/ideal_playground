
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchUserRepository {
    final FirebaseFirestore _fireStore;

  SearchUserRepository({FirebaseFirestore? fireStore})
      : _fireStore = fireStore ?? FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> searchUser(String query) {
      final lowercaseQuery = query.toLowerCase();

      final users = _fireStore
          .collection('users')
          .where('lowercaseName', isGreaterThanOrEqualTo: lowercaseQuery)
          .where('lowercaseName', isLessThan: '${lowercaseQuery}z')
          .limit(10)
          .snapshots();
      return users;
    }

  Stream<QuerySnapshot<Map<String,dynamic>>> searchUserAll(String userId){
    return _fireStore
        .collection('users')
        .doc(userId)
        .collection('matchedList')
        .snapshots();
  }

}