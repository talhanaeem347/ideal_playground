part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
  @override
  List<Object> get props => [];
}

class LoadSettings extends SettingsEvent{
  final String userId;

  const LoadSettings({required this.userId});
  @override
  List<Object> get props => [userId];
}

class UpdateDarkMode extends SettingsEvent{
  final String userId;
  final bool isDarkMode;

  const UpdateDarkMode({required this.userId, required this.isDarkMode});
  @override
  List<Object> get props => [userId, isDarkMode];
}