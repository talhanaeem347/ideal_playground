import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';

class UserModel {
  String id = "";
  String email = "";
  String name = "";
  String lowercaseName = "";
  String interestedIn = "";
  String phone = "";
  String gender = "";
  String city = "";
  String state = "";
  String country = "";
  String photoUrl = "";
  String token = "";
  DateTime dateOfBirth = AppStrings.maxDate;
  GeoPoint location = const GeoPoint(0, 0);
  bool isOnline = false;
  bool isMarried = false;
  bool isOpen = true;

  UserModel({
    this.id = "",
    this.email = "",
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
    this.lowercaseName = "",
  }) : dateOfBirth = dateOfBirth ?? AppStrings.maxDate;

  UserModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
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
    gender = json['gender'];
    lowercaseName = json['lowercaseName'];

  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
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
    data['gender'] = gender;
    data['lowercaseName'] = lowercaseName;
    return data;
  }

  set onLine(bool value) {
    isOnline = value;
  }
}
