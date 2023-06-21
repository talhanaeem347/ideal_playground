
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsRepository{
  final FirebaseFirestore _fireStore;

  SettingsRepository({FirebaseFirestore? fireStore}) : _fireStore = fireStore ?? FirebaseFirestore.instance;

  Future<void> UpdateDarkMode({required String userId, required bool darkMode}) async {
    await _fireStore.collection('users').doc(userId).update({'darkMode': darkMode});
  }

  Future<bool> getDarkMode({required String userId}) async {
    try {
      DocumentSnapshot snapshot = await _fireStore.collection('users').doc(
          userId).get();
      return (snapshot.data() as Map<String, dynamic>) !['darkMode'] as bool;
    } catch (e) {
      return false;
    }
  }

  Future<String>  getUserImage({required String userId}) async {
    try {
      DocumentSnapshot snapshot = await _fireStore.collection('users').doc(
          userId).get();
      return (snapshot.data() as Map<String, dynamic>)['photoUrl'];
    } catch (e) {
      return '';
    }
  }

}