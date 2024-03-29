
import 'package:flutter/material.dart';
import 'package:ideal_playground/bloc/message/message_bloc.dart';
import 'package:ideal_playground/models/chat_room_model.dart';
import 'package:ideal_playground/models/message.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:ideal_playground/repositories/message_repository.dart';
import 'package:ideal_playground/ui/pages/chat_room.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'page_turn.dart';

class ChatWidget extends StatefulWidget {
  final ChatRoomModel chatRoom;
  final String userId;
  final MessageBloc messageBloc;

  const ChatWidget({Key? key, required this.chatRoom, required this.userId, required this.messageBloc})
      : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final MessageRepository _messageRepository = MessageRepository();

  ChatRoomModel get _chatRoom => widget.chatRoom;

  String get _userId =>
      _chatRoom.users.keys.firstWhere((element) => element != widget.userId);

  Future<Map<String, dynamic>> getDetails() async {
    final UserModel user = await _messageRepository.getUser(userId: _userId);
    final lastMessage = _chatRoom.lastMessage;
    return {'user': user, 'lastMessage': lastMessage};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getDetails(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final UserModel user = snapshot.data!['user'];
          final Message lastMessage = snapshot.data!['lastMessage'];

          return GestureDetector(
            onTap: () {
              pageTurn(
                context: context,
                page: ChatRoom(
                  matchId: user.id,
                  userId: widget.userId,
                ),
              );
            },
            onLongPress: () {
              showDialog(context: context, builder: (context) => AlertDialog(
                title: const Text('Block User'),
                content: const Text('Are you sure you want to block this User?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No')),
                  TextButton(
                      onPressed: () {
                        widget.messageBloc.add(BlockUserEvent(userId: widget.userId, chatRoomId:_chatRoom.chatRoomId ));
                      },
                      child: const Text('Yes')),
                ],
              ));

            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              decoration: BoxDecoration(
                color: user.isOnline ? AppColors.white.withOpacity(0.3) :AppColors.white.withOpacity(0.2),
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.black,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.photoUrl),
                        radius: 27,
                      ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        user.name,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.black),
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
                  ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        timeago.format(lastMessage.time.toDate()),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.black.withOpacity(0.7)),
                      ),
                      const SizedBox(height: 5),
                      lastMessage.isSeen
                          ? const SizedBox()
                          :   CircleAvatar(
                              radius: 7,
                              backgroundColor: lastMessage.senderId == widget.userId ? AppColors.blue : AppColors.green,
                            )  ,
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return Container(
          height: 60,
        );
      },
    );
  }
}
