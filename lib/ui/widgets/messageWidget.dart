
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ideal_playground/bloc/messaging/messaging_bloc.dart';
import 'package:ideal_playground/helpers/date_time.dart';
import 'package:ideal_playground/models/message.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

Widget messageWidget({required QueryDocumentSnapshot<Map<String,dynamic>> data, required Size size, required String userId, required MessagingBloc messagingBloc, required String chatRoomId}) {
  Message message = Message.fromMap(data.data());
  if(message.senderId.toString() != userId.toString() && !message.isSeen ){
    messagingBloc.add(UpdateMessage(messageId: message.id, chatRoomId: chatRoomId));
  }
  return Container(
    height: 60,
    color: AppColors.transparent,
    child: message.senderId == userId ? Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.grey.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), topLeft: Radius.circular(15), topRight: Radius.circular(15))

              ) ,
              child: Text(message.content),
            ),
              const SizedBox(height: 5,),
            Text( dateToTime(message.time.toDate()), style: const TextStyle(fontSize: 12),),
          ],
        )
      ],
    ) :
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color:  AppColors.grey.withOpacity(0.2),
                  borderRadius: const BorderRadius.only( bottomRight: Radius.circular(15), topLeft: Radius.circular(15), topRight: Radius.circular(15))

              ) ,
              child: Text(message.content),
            ),
            const SizedBox(height: 5,),
            Text( dateToTime(message.time.toDate()), style: const TextStyle(fontSize: 12),),
          ],
        )
      ],
    ),
  );
}