import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ideal_playground/helpers/theme_helper.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<ThemeInitialEvent>(_onThemeInitialEvent);
    on<ThemeToggleEvent>(_onThemeToggleEvent);
  }

  FutureOr<void> _onThemeInitialEvent(ThemeInitialEvent event, Emitter<ThemeState> emit) {
  emit(const ThemeLoaded(isDarkMode: false));
  }


  FutureOr<void> _onThemeToggleEvent(ThemeToggleEvent event, Emitter<ThemeState> emit) {
    ThemeHelper.toggleTheme(event.isDarkMode);
  emit(ThemeLoaded(isDarkMode: event.isDarkMode));
  }
}
