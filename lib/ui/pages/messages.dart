import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/message/message_bloc.dart';
import 'package:ideal_playground/models/chat_room_model.dart';
import 'package:ideal_playground/repositories/message_repository.dart';
import 'package:ideal_playground/ui/widgets/chat_widget.dart';
import 'package:ideal_playground/ui/widgets/page_turn.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

import 'search_user.dart';

class Messages extends StatefulWidget {
  final String userId;

  const Messages({Key? key, required this.userId}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final MessageRepository _messageRepository = MessageRepository();
  late MessageBloc _messageBloc;

  get _userId => widget.userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messageBloc = MessageBloc(messageRepository: _messageRepository);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      bloc: _messageBloc,
      builder: (context, state) {
        if (state is MessageInitial) {
          _messageBloc.add(LoadChatsEvent(userId: _userId));
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ChatsloadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ChatRoomsLoaded) {
          return Scaffold(
            body: StreamBuilder<QuerySnapshot>(
                stream: state.chatRooms,
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    if (snapShot.data!.docs.isNotEmpty) {
                      if (snapShot.connectionState != ConnectionState.waiting) {
                        final list = snapShot.data!.docs;
                        return Container(
                            padding: const EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: const EdgeInsets.all(4),
                                    child: ChatWidget(
                                          messageBloc: _messageBloc,
                                        chatRoom: ChatRoomModel.fromMap(
                                            list[index].data()
                                                as Map<String, dynamic>),
                                        userId: widget.userId));
                              },
                            ));
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                  if (snapShot.hasError) {
                    return const Center(
                      child: Text("Some Thing Went Wrong"),
                    );
                  }
                  return const Center(
                    child: Text("ّYou Have No Messages"),
                  );
                }),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.yellow,

              onPressed: () {
                pageTurn(context: context, page:  SearchUser(userId: _userId,));
              },
              child: const Icon(Icons.search, size: 45,),
            )
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
