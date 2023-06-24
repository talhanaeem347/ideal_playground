import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:ideal_playground/models/chat_room_model.dart';
import 'package:ideal_playground/repositories/message_repository.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository _messageRepository;
  MessageBloc({required MessageRepository messageRepository}) : _messageRepository = messageRepository, super(MessageInitial()) {
    on<LoadChatsEvent>(_loadChats);
    on<BlockUserEvent>(_blockUser);
    // on<SearchMatchEvent>(_searchMatch);
  }


  void _loadChats(LoadChatsEvent event, Emitter<MessageState> emit) async {
    emit(ChatsloadingState());
    try {
      final Stream<QuerySnapshot> chatsRooms = _messageRepository.getChats(userId: event.userId);
      emit(ChatRoomsLoaded(chatRooms: chatsRooms));
    } catch (e) {
      emit(ChatRoomError(e.toString()));
    }
  }

  void _blockUser(BlockUserEvent event, Emitter<MessageState> emit) async {
    _messageRepository.blockUser(userId:event.userId,chatRoomId: event.chatRoomId);
  }
}
