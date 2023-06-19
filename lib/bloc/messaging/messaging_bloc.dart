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
    on<LoadChatRoam>(_loadChatRoam);
    on<SendMessage>(_sendMessage);
  }

  void _loadChatRoam(LoadChatRoam event, Emitter<MessagingState> emit) {
    emit(MessagingLoading());

    final messages =  _messagingRepository.getMessages(chatRoamId: event.chatRoamId);

    emit(MessagingLoaded(messages: messages));



  }

  void _sendMessage(SendMessage event, Emitter<MessagingState> emit) async {
    await _messagingRepository.sendMessage(chatRoamId: event.chatRoamId, senderId: event.senderId, content: event.content, type: event.type);
    final messages =  _messagingRepository.getMessages(chatRoamId: event.chatRoamId);
    emit(MessagingLoaded(messages: messages));
  }

}
