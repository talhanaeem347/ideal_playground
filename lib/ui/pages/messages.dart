import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/message/message_bloc.dart';
import 'package:ideal_playground/repositories/message_repository.dart';
import 'package:ideal_playground/ui/widgets/page_turn.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messageBloc = MessageBloc(messageRepository: _messageRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text("Messages")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.search),
      ),
    );
  }
}

