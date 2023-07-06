
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:ideal_playground/repositories/user_repository.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserRepository _userRepository;
  UserProfileBloc({required UserRepository userRepository}) : _userRepository = userRepository ,super(UserProfileInitial()) {
    on<UserProfileEvent>((event, emit) async {
      // TODO: implement event handler
      if(event is LoadUserProfile) {
       await  loadUserProfileState(event, emit);
      }
    });
  }

  FutureOr<void> loadUserProfileState(LoadUserProfile event, Emitter<UserProfileState> emit) async {
    emit(UserProfileLoading());
    try {
      final UserModel user = await _userRepository.getUserDetails(event.userId);
      print(user.toMap());
       emit(UserProfileLoaded(user: user));
    } catch (e) {
      emit(UserProfileError(message: e.toString()));
    }

  }





}

