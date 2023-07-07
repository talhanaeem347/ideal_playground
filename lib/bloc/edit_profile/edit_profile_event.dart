part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];

}

class LoadProfile extends EditProfileEvent{
  final String uid;
  const LoadProfile({required this.uid});

  @override
  List<Object> get props => [uid];
}

class PhotoUrlChanged extends EditProfileEvent{}

class NameChanged extends EditProfileEvent {
  final String name;
  const NameChanged({required this.name});

  @override
  List<Object> get props => [name];
}


class PhoneChanged extends EditProfileEvent{
  final String phone;
  const PhoneChanged({required this.phone});

  @override
  List<Object> get props => [phone];
}

class CityChanged extends EditProfileEvent{
  final String city;
  const CityChanged({required this.city});

  @override
  List<Object> get props => [city];
}

class StateChanged extends EditProfileEvent{
  final String state;
  const StateChanged({required this.state});

  @override
  List<Object> get props => [state];
}

class CountryChanged extends EditProfileEvent{
  final String country;
  const CountryChanged({required this.country});

  @override
  List<Object> get props => [country];
}

class IsMarriedChanged extends EditProfileEvent{
  final bool isMarried;
  const IsMarriedChanged({required this.isMarried});

  @override
  List<Object> get props => [isMarried];
}

class IsOpenChanged extends EditProfileEvent{
  final bool isOpen;
  const IsOpenChanged({required this.isOpen});

  @override
  List<Object> get props => [isOpen];
}

class  InterestedInChanged extends EditProfileEvent{
  final String interestedIn;
  const  InterestedInChanged({required this.interestedIn});

  @override
  List<Object> get props => [interestedIn];
}

class UpdateProfile extends EditProfileEvent{}