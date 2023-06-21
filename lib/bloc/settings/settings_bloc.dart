import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ideal_playground/repositories/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository;
  SettingsBloc({required SettingsRepository settingsRepository}) : _settingsRepository = settingsRepository, super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateDarkMode>(_onUpdateDarkMode);
  }

  FutureOr<void> _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    try{
    String photoUrl = await  _settingsRepository.getUserImage(userId: event.userId);
    bool isDarkMod =await _settingsRepository.getDarkMode(userId: event.userId);
    emit(SettingsLoaded(isDarkMode: isDarkMod, photoUrl: photoUrl));
    }catch(e){
      emit(SettingsError(message: e.toString()));
    }
  }

  FutureOr<void> _onUpdateDarkMode(UpdateDarkMode event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    try {
      await _settingsRepository.UpdateDarkMode(userId: event.userId, darkMode: event.isDarkMode);
      String photoUrl = await  _settingsRepository.getUserImage(userId: event.userId);
      emit(SettingsLoaded(isDarkMode: event.isDarkMode, photoUrl: photoUrl));
    } catch (e) {
      emit(SettingsError(message: e.toString()));
    }
  }
}
