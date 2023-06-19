import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/messaging/messaging_bloc.dart';
import 'package:ideal_playground/models/chat_roam_model.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:ideal_playground/repositories/messaging_repository.dart';
import 'package:ideal_playground/ui/widgets/messageWidget.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class ChatRoam extends StatefulWidget {
  final ChatRoamModel chatRoam;
  final UserModel user;

  const ChatRoam({Key? key, required this.chatRoam, required this.user})
      : super(key: key);

  @override
  State<ChatRoam> createState() => _ChatRoamState();
}

class _ChatRoamState extends State<ChatRoam> {
  final TextEditingController _messageController = TextEditingController();
  final MessagingRepository _messagingRepository = MessagingRepository();
  late MessagingBloc _messagingBloc;
  bool isTyping = false;

  get chatRoamId => widget.chatRoam.chatRoamId;

  get user => widget.user;

  get userId => widget.chatRoam.users.keys.toList().firstWhere((element) => element == user.id);

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _messagingBloc = MessagingBloc(messagingRepository: _messagingRepository);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<MessagingBloc, MessagingState>(
      bloc: _messagingBloc,
      builder: (context, state) {
        if (state is MessagingInitial) {
          _messagingBloc.add(LoadChatRoam(chatRoamId: chatRoamId));
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MessagingLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MessagingLoaded) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(user.photoUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(user.name),
                ],
              ),
            ),
            body: SafeArea(
              child: Container(
                height: size.height,
                color: AppColors.white,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: StreamBuilder(
                        stream: state.messages,
                        builder: (context, snapShot) {
                          if (snapShot.hasData) {
                            final list = snapShot.data!.docs;
                            return ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return messageWidget(
                                      data: list[index], size: size, userId: userId);
                                });
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: AppColors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              controller: _messageController,
                              onChanged: (value) {
                                setState(() {
                                  isTyping = value.isNotEmpty;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'Type a message',
                              ),
                              style: TextStyle(
                                fontSize: 20,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (_messageController.text.isEmpty) {
                              return;
                            }
                            final str = _messageController.text;
                            _messageController.text = '';
                            setState(() {
                              isTyping = false;
                            });
                            _messagingBloc.add(SendMessage(
                              content: str,
                              chatRoamId: chatRoamId,
                              senderId: user.id,
                              type: 'text',
                            ));
                          },
                          icon: Icon(
                            Icons.send,
                            color: isTyping ? AppColors.yellow : AppColors.grey,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Center(
          child: Text("Something went wrong"),
        );
      },
    );
  }
}
