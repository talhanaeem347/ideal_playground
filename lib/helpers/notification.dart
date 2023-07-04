
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Notification{

  static Future<void> sendPushNotification({required String token,required String title,required String imageUrl,required String message })async{
    final body = {
      "notification": {
        "title": title,
        "body": message,
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "image": imageUrl,

      },

      "to": token
    };

    try{
      var response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'), body: jsonEncode(body),headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'key=AAAAohx05W0:APA91bEgmtv585La3gLXsLnTIrz94e57VoxCG3u9Q3V3AWVJQKDvM9f_XuyO3X6kPDVR7JezOr0OKyi_DTz7auAhOdrwkfYjGn7CtflE_zt8TeEOj-HrLaRd6ewsj3b8gUPBBMWj3353'
      });
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      print(await http.read(Uri.https('example.com', 'foobar.txt')));
    }catch(e){
      print(e);
    }
  }
}