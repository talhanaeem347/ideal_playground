part of 'profile_bloc.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}
class NameChanged extends ProfileEvent {
  final String name;
  const NameChanged({required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'NameChanged { name :$name }';
}

class GenderChanged extends ProfileEvent{
  final String gender;
  const GenderChanged({required this.gender});

  @override
  List<Object> get props => [gender];
}

class PhoneChanged extends ProfileEvent{
  final String phone;
  const PhoneChanged({required this.phone});

  @override
  List<Object> get props => [phone];
}

class CityChanged extends ProfileEvent{
  final String city;
  const CityChanged({required this.city});

  @override
  List<Object> get props => [city];
}

class StateChanged extends ProfileEvent{
  final String state;
  const StateChanged({required this.state});

  @override
  List<Object> get props => [state];
}

class CountryChanged extends ProfileEvent{
  final String country;
  const CountryChanged({required this.country});

  @override
  List<Object> get props => [country];
}

class PhotoUrlChanged extends ProfileEvent{}

class LocationChanged extends ProfileEvent{
  final GeoPoint location;
  const LocationChanged({required this.location});

  @override
  List<Object> get props => [location];
}

class TokenChanged extends ProfileEvent{
  final String token;
  const TokenChanged({required this.token});

  @override
  List<Object> get props => [token];
}
class IsOnlineChanged extends ProfileEvent{
  final bool isOnline;
  const IsOnlineChanged({required this.isOnline});

  @override
  List<Object> get props => [isOnline];
}
class DateOfBirthChanged extends ProfileEvent{
  final BuildContext context;
  const DateOfBirthChanged({required this.context});

  @override
  List<Object> get props => [context];
}
class InterestedInChanged extends ProfileEvent{
  final String interestedIn;
  const InterestedInChanged({required this.interestedIn});

  @override
  List<Object> get props => [interestedIn];
}
class ProfileSaveButtonClicked extends ProfileEvent{
  const ProfileSaveButtonClicked();

  @override
  List<Object> get props => [];
}

class ProfileSubmitted extends ProfileEvent{
  final UserModel user;
  const ProfileSubmitted({required this.user});

  @override
  List<Object> get props => [user];
}
class IsMarriedChanged extends ProfileEvent{
  final bool isMarried;
  const IsMarriedChanged({required this.isMarried});

  @override
  List<Object> get props => [isMarried];
}
class IsOpenChanged extends ProfileEvent{
  final bool isOpen;
  const IsOpenChanged({required this.isOpen});

  @override
  List<Object> get props => [isOpen];
}

class ProfileLoad extends ProfileEvent{
  final String userId;
  const ProfileLoad({required this.userId});

  @override
  List<Object> get props => [userId];
}