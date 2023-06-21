part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  @override
  List<Object> get props => [];
}

class ThemeInitialEvent extends ThemeEvent {}

class ThemeToggleEvent extends ThemeEvent {
  final bool isDarkMode;
  const ThemeToggleEvent({required this.isDarkMode});
  @override
  List<Object> get props => [isDarkMode];
}


