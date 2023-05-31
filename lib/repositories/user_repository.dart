import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/authentication/authentication_bloc.dart';
import 'package:ideal_playground/models/user.dart';

class UserRepository {
  // final FirebaseFirestore _fireStore;
  final CollectionReference _userCollection;
  final FirebaseAuth _firebaseAuth;

  UserRepository({
    // FirebaseFirestore? fireStore,
    CollectionReference? userCollection,
    FirebaseAuth? firebaseAuth,
  })  :
        // _fireStore = fireStore ?? FirebaseFirestore.instance,
        _userCollection =
            userCollection ?? FirebaseFirestore.instance.collection('users'),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signInWithEmail(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<bool?> isFirstTime(String uid) async {
    final doc = await _userCollection.doc(uid).get();
    if(doc.exists){
      final data = doc.data() as Map<String, dynamic>;
      return  data["name"].isEmpty;
    }
    else{
      final user = await getCurrentUser();
      user.delete();
      return null;


    }
  }

  Future<bool> userNotComplete(String uid) async {
    final doc = await _userCollection.doc(uid).get();
    final data = doc.data() as Map<String, dynamic>;
    return doc.exists && (data["phone"] == null || data["phone"].isEmpty);
  }

  Future<void> signUpWithEmail(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<bool> isLoggedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<String> getCurrentUserId() async {
    return _firebaseAuth.currentUser!.uid;
  }

  Future<User> getCurrentUser() async {
    return _firebaseAuth.currentUser!;
  }

//  Profile Setup
  Future<void> createProfile(String uid, Map<String, dynamic> data) async {
    return await _userCollection.doc(uid).set(data);
  }

  Future<void> updateProfile(String uid, Map<String, dynamic> data) async {
    return await _userCollection.doc(uid).update(data);
  }

  Future<String> uploadProfilePicture(String uid, String url) async {
    final TaskSnapshot uploadTask =
        await FirebaseStorage.instance.ref("profile/$uid").putFile(File(url));
    return await uploadTask.ref.getDownloadURL();
  }

  Future<UserModel> getUserDetails(String uid) async {
    DocumentSnapshot snapshot = await _userCollection.doc(uid).get();
     UserModel user = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
      return user;
  }
}
