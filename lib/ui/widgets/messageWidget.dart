
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ideal_playground/models/message.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

Widget messageWidget({required QueryDocumentSnapshot<Map<String,dynamic>> data, required Size size, required String userId}) {
  Message message = Message.fromMap(data.data());
  print(message.time.toDate().hour % 12);
  return Container(
    height: 60,
    color: AppColors.transparent,
    child: Row(
      mainAxisAlignment: message.senderId == userId ? MainAxisAlignment.end: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: message.senderId != userId ? AppColors.grey.withOpacity(0.2) :  AppColors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(message.senderId == userId ? 15 : 0), bottomRight: Radius.circular(message.senderId == userId ? 0 : 15), topLeft: Radius.circular(15), topRight: Radius.circular(15))

              ) ,
              child: Text(message.content),
            ),
            Text('${message.time.toDate().hour % 12}:${message.time.toDate().minute} ${message.time.toDate().hour / 12 > 0 ?  "PM" : "AM" } ', style: TextStyle(fontSize: 12),),
          ],
        )
      ],
    ),
  );
}