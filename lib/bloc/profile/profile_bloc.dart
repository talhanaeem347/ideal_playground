import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:ideal_playground/repositories/user_repository.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;

  ProfileBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(ProfileState.initial()) {
    on<NameChanged>(_mapNameChangedToState);
    on<GenderChanged>(_mapGenderChangedToState);
    on<PhoneChanged>(_mapPhoneChangedToState);
    on<CityChanged>(_mapCityChangedToState);
    on<StateChanged>(_mapStateChangedToState);
    on<CountryChanged>(_mapCountryChangedToState);
    on<PhotoUrlChanged>(_mapPhotoUrlChangedToState);
    on<LocationChanged>(_mapLocationChangedToState);
    on<DateOfBirthChanged>(_mapDateOfBirthChangedToState);
    on<InterestedInChanged>(_mapInterestedInChangedToState);
    on<ProfileSubmitted>(_mapProfileSubmittedToState);
    on<ProfileSaveButtonClicked>(_mapProfileSaveButtonClickedToState);
    on<IsMarriedChanged>(_mapIsMarriedChangedToState);
    on<IsOpenChanged>(_mapIsOpenChangedToState);
    on<ProfileLoad>(_mapProfileLoadToState);
  }

  void _mapNameChangedToState(event, emit) {
    emit(state.update(name: event.name));
  }

  void _mapGenderChangedToState(event, emit) {
    emit(state.update(gender: event.gender));
  }

  void _mapPhoneChangedToState(event, emit) {
    emit(state.update(phone: event.phone));
  }

  void _mapCityChangedToState(event, emit) {
    emit(state.update(city: event.city));
  }

  void _mapStateChangedToState(event, emit) {
    emit(state.update(state: event.state));
  }

  void _mapCountryChangedToState(event, emit) {
    emit(state.update(country: event.country));
  }

  void _mapPhotoUrlChangedToState(event, emit) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      emit(state.update(filePhoto: result.files.single.path!));
    }
  }

  void _mapLocationChangedToState(event, emit) {
    emit(state.update(location: event.location));
  }

  void _mapDateOfBirthChangedToState(event, emit) async {
    final value = await showDatePicker(
      context: event.context,
      initialDate: DateTime(state.user.dateOfBirth.year - 1),
      firstDate: AppStrings.minDate,
      lastDate: AppStrings.maxDate,
    );

    if (value != null) {
      emit(state.update(
          dateOfBirth: DateTime(value.year, value.month, value.day)));
    }
  }

  void _mapInterestedInChangedToState(event, emit) {
    emit(state.update(interestedIn: event.interestedIn));
  }

  void _mapProfileSaveButtonClickedToState(event, emit) async {
    emit(state.loading());
    try {
      String uid = await _userRepository.getCurrentUserId();
      String url =
          await _userRepository.uploadProfilePicture(uid, state.filePhoto);
      await emit(state.update(photoUrl: url));
      await _userRepository.createProfile(uid, state.user.toMap());

      emit(state.success());
    } catch (e) {
      emit(state.failure());
    }
  }

  void _mapProfileSubmittedToState(event, emit) async {
    emit(state.loading());
    try {
      final uid = await _userRepository.getCurrentUserId();
      await _userRepository.updateProfile(uid, event.user.toMap());
      emit(state.success());
    } catch (_) {
      emit(state.failure());
    }
  }

  void _mapIsMarriedChangedToState(event, emit) {
    emit(state.update(isMarried: event.isMarried));
  }

  void _mapIsOpenChangedToState(event, emit) {
    emit(state.update(isOpen: event.isOpen));
  }

  void _mapProfileLoadToState(event, emit) async {
    emit(state.loading());
    try {
      final UserModel user = await _userRepository.getUserDetails(event.userId);
      emit(state.updateUser(user: user));
    } catch (e) {
      emit(state.failure());
    }
  }
}
