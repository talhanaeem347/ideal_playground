part of 'messaging_bloc.dart';

abstract class MessagingState extends Equatable {
  const MessagingState();
  @override
  List<Object> get props => [];
}

class MessagingInitial extends MessagingState {

}

class MessagingLoading extends MessagingState {

}

class MessagingError extends MessagingState {

}

class MessagingLoaded extends MessagingState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> messages;
  const MessagingLoaded({required this.messages});

  bool isTyping(value){
    return   value.isNotEmpty;
  }

  @override
  List<Object> get props => [messages];
}


