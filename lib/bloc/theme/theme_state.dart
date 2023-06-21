part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  @override
  List<Object> get props => [];
}

class ThemeLoading extends ThemeState {
  @override
  List<Object> get props => [];
}

class ThemeLoaded extends ThemeState {
  final bool isDarkMode;
  const ThemeLoaded({required this.isDarkMode});
  @override
  List<Object> get props => [isDarkMode];
}

class ThemeError extends ThemeState {
  final String message;
  const ThemeError({required this.message});
  @override
  List<Object> get props => [message];
}

