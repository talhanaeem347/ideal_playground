import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';

class User {
  String name = "";
  String gender = "";
  String interestedIn = "";
  String phone = "";
  String city = "";
  String state = "";
  String country = "";
  String photoUrl = "";
  String token = "";
  DateTime dateOfBirth = DateTime(2000, 1, 1);
  GeoPoint location = const GeoPoint(0, 0);
  bool isOnline = false;
  bool isMarried = false;
  bool isOpen = true;

  User({
    this.name = "",
    this.gender = "",
    this.phone = "",
    this.city = "",
    this.state = "",
    this.country = "",
    this.photoUrl = "",
    this.token = "",
    DateTime? dateOfBirth,
    this.location = const GeoPoint(0, 0),
    this.isOnline = true,
    this.interestedIn = "",
    this.isMarried = false,
    this.isOpen = true,
  }) : dateOfBirth = dateOfBirth ?? AppStrings.maxDate;

  User.fromMap(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    photoUrl = json['photoUrl'];
    token = json['token'];
    location = json['location'];
    isOnline = json['isOnline'];
    dateOfBirth = DateTime.parse(json['dateOfBirth']);
    interestedIn = json['interestedIn'];
    isMarried = json['isMarried'];
    isOpen = json['isOpen'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['photoUrl'] = photoUrl;
    data['token'] = token;
    data['location'] = location;
    data['isOnline'] = isOnline;
    data['dateOfBirth'] = dateOfBirth.toString();
    data['interestedIn'] = interestedIn;
    data['isMarried'] = isMarried;
    data['isOpen'] = isOpen;
    return data;
  }

  set onLine(bool value) {
    isOnline = value;
  }
}
