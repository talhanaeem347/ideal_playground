// import 'package:flutter/material.dart';
// import 'package:ideal_playground/models/chat_roam_model.dart';
// import 'package:ideal_playground/repositories/message_repository.dart';
// import 'package:ideal_playground/ui/pages/chat_roam.dart';
//
// class ChatWidget extends StatefulWidget {
//   final ChatRoamModel chatRoam;
//   final String userId;
//
//   const ChatWidget({Key? key, required this.chatRoam, required this.userId})
//       : super(key: key);
//
//   @override
//   State<ChatWidget> createState() => _ChatWidgetState();
// }
//
// class _ChatWidgetState extends State<ChatWidget> {
//   final MessageRepository _messageRepository = MessageRepository();
//
//   get _chatRoam => widget.chatRoam;
//
//   get _userId => _chatRoam.users.keys
//       .toList()
//       .firstWhere((element) => element != widget.userId);
//
//   get user => _messageRepository.getUser(userId: _userId);
//
//   getDetails() async {
//     final _user = await user;
//     final _lastMessage = _chatRoam.lastMessage;
//     return {'user': _user, 'lastMessage': _lastMessage};
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: getDetails(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final user = snapshot.data['user'];
//           final lastMessage = snapshot.data['lastMessage'];
//           return ListTile(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ChatRoam(
//                           chatRoam: _chatRoam, userId: widget.userId)));
//             },
//             onLongPress: () {
//               showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                         title: const Text('Block User'),
//                         content: const Text(
//                             'Are you sure you want to block this User?'),
//                         actions: [
//                           TextButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: const Text('No')),
//                           TextButton(
//                               onPressed: () {
//                                 print("No");
//                               },
//                               child: const Text('Yes')),
//                         ],
//                       ));
//             },
//             leading: CircleAvatar(
//               backgroundImage: NetworkImage(user.profileImage),
//             ),
//             title: Text(user.name),
//             subtitle: Text(
//                 lastMessage != null ? lastMessage.message : 'No messages yet'),
//           );
//         }
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:ideal_playground/models/chat_roam_model.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:ideal_playground/repositories/message_repository.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class ChatWidget extends StatefulWidget {
  final ChatRoamModel chatRoam;
  final String userId;

  const ChatWidget({Key? key, required this.chatRoam, required this.userId})
      : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final MessageRepository _messageRepository = MessageRepository();

  ChatRoamModel get _chatRoam => widget.chatRoam;

  String get _userId =>
      _chatRoam.users.keys.firstWhere((element) => element != widget.userId);

  Future<Map<String, dynamic>> getDetails() async {
    final UserModel user = await _messageRepository.getUser(userId: _userId);
    final lastMessage = _chatRoam.lastMessage;
    return {'user': user, 'lastMessage': lastMessage};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getDetails(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final UserModel user = snapshot.data!['user'];
          final lastMessage = snapshot.data!['lastMessage'];

          return GestureDetector(
            onTap: () {
              print("chat Model");
            },
            onLongPress: () {
              print("longPressed");
            },
            child: Container(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.photoUrl),
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(fontSize: 20, color: AppColors.black),
                      ),
                      lastMessage.type == 'image'
                          ? const Row(
                              children: [Icon(Icons.image), Text("Photo")],
                            )
                          : Text(
                              lastMessage.content,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                    ],
                  )
                ],
              ),
            ),
          );
          // return ListTile(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => ChatRoam(
          //           chatRoam: _chatRoam,
          //           userId: widget.userId,
          //         ),
          //       ),
          //     );
          //   },
          //   onLongPress: () {
          //     showDialog(
          //       context: context,
          //       builder: (context) => AlertDialog(
          //         title: const Text('Block User'),
          //         content: const Text('Are you sure you want to block this User?'),
          //         actions: [
          //           TextButton(
          //             onPressed: () {
          //               Navigator.pop(context);
          //             },
          //             child: const Text('No'),
          //           ),
          //           TextButton(
          //             onPressed: () {
          //               print('Yes');
          //             },
          //             child: const Text('Yes'),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          //   leading: CircleAvatar(
          //     backgroundImage: NetworkImage(user.profileImage),
          //   ),
          //   title: Text(user.name),
          //   subtitle: Text(lastMessage != null ? lastMessage.message : 'No messages yet'),
          // );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
