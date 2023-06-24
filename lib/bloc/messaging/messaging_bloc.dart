import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:ideal_playground/repositories/messaging_repository.dart';

part 'messaging_event.dart';
part 'messaging_state.dart';

class MessagingBloc extends Bloc<MessagingEvent, MessagingState> {
  final MessagingRepository _messagingRepository;
  MessagingBloc({required MessagingRepository messagingRepository}) :_messagingRepository = messagingRepository, super(MessagingInitial()) {
    on<LoadChatRoom>(_loadChatRoom);
    on<SendMessage>(_sendMessage);
    on<UpdateMessage>(_updateMessage);
  }

  void _loadChatRoom(LoadChatRoom event, Emitter<MessagingState> emit) async {
    emit(MessagingLoading());
    final messages =  _messagingRepository.getMessages(chatRoomId: event.chatRoomId);
    emit(MessagingLoaded(messages: messages));

  }

  void _sendMessage(SendMessage event, Emitter<MessagingState> emit) async {
    await _messagingRepository.sendMessage(chatRoomId: event.chatRoomId, senderId: event.senderId, content: event.content, type: event.type);
    final messages =  _messagingRepository.getMessages(chatRoomId: event.chatRoomId);
    emit(MessagingLoaded(messages: messages));
  }


  FutureOr<void> _updateMessage(UpdateMessage event, Emitter<MessagingState> emit) {
    _messagingRepository.updateMessageSeen(chatRoomId: event.chatRoomId, messageId: event.messageId);
    // final messages =  _messagingRepository.getMessages(chatRoomId: event.chatRoomId);
    // emit(MessagingLoaded(messages: messages));
  }
}
