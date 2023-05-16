import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name = "";
  String email = "";
  String password = "";
  String gender = "";
  String phone = "";
  String city = "";
  String state = "";
  String country = "";
  String zip = "";
  String photoUrl = "";
  String uid = "";
  String token = "";
  String createdAt = "";
  String updatedAt = "";
  GeoPoint location = const GeoPoint(0, 0);
  bool isOnline = false;

  User({
    this.name = "",
    this.email = "",
    this.password = "",
    this.phone = "",
    this.city = "",
    this.state = "",
    this.country = "",
    this.zip = "",
    this.photoUrl = "",
    this.uid = "",
    this.token = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.location = const GeoPoint(0, 0),
    this.isOnline = true,
  });

   User.fromMap(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zip = json['zip'];
    photoUrl = json['photoUrl'];
    uid = json['uid'];
    token = json['token'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    location = json['location'];
    isOnline = json['isOnline'];

  }

   Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['zip'] = zip;
    data['photoUrl'] = photoUrl;
    data['uid'] = uid;
    data['token'] = token;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['location'] = location;
    data['isOnline'] = isOnline;
    return data;
  }
  set onLine(bool value) {
    isOnline = value;
  }


}
