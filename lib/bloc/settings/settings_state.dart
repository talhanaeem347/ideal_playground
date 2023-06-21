part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  String photoUrl;
  bool isDarkMode;
   SettingsLoaded({required this.photoUrl, required this.isDarkMode});
  @override
  List<Object> get props => [photoUrl, isDarkMode];
}

class SettingsError extends SettingsState {
  final String message;
  const SettingsError({required this.message});
  @override
  List<Object> get props => [message];
}


