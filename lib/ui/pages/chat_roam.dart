import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/messaging/messaging_bloc.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:ideal_playground/repositories/messaging_repository.dart';
import 'package:ideal_playground/ui/widgets/messageWidget.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class ChatRoam extends StatefulWidget {
  final String userId, matchId;

  const ChatRoam({Key? key, required this.userId, required this.matchId})
      : super(key: key);

  @override
  State<ChatRoam> createState() => _ChatRoamState();
}

class _ChatRoamState extends State<ChatRoam> {
  final TextEditingController _messageController = TextEditingController();
  final MessagingRepository _messagingRepository = MessagingRepository();
  late MessagingBloc _messagingBloc;
  bool isTyping = false;

  Future<String> getChatRoamId() async {
    final value = await _messagingRepository.getChatRoam(
      userId: userId,
      matchedUserId: matchId,
    );
    return value;
  }

  Future<UserModel> getUser() async =>
      await _messagingRepository.getUser(userId: matchId);

  Future<void> getDetails() async {
    final chatRoamId = await getChatRoamId();
    final user = await getUser();

    setState(() {
      this.chatRoamId = chatRoamId;
      this.user = user;
    });
  }

  late UserModel user;
  String chatRoamId = "";

  get userId => widget.userId;

  get matchId => widget.matchId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messagingBloc = MessagingBloc(messagingRepository: _messagingRepository);
    getDetails()
        .then((_) => _messagingBloc.add(LoadChatRoam(chatRoamId: chatRoamId)));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.white,
      child: BlocBuilder<MessagingBloc, MessagingState>(
        bloc: _messagingBloc,
        builder: (context, state) {
          if (state is MessagingInitial) {
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
                                reverse: true,
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {

                                    return messageWidget(
                                      messagingBloc: _messagingBloc,
                                        chatRoamId: chatRoamId,
                                        data: list[index],
                                        size: size,
                                        userId: userId);
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
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
                                senderId: userId,
                                type: 'text',
                              ));
                            },
                            icon: Icon(
                              Icons.send,
                              color:
                                  isTyping ? AppColors.yellow : AppColors.grey,
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
          return Center(
            child: Text(AppStrings.failureMessage),
          );
        },
      ),
    );
  }
}
