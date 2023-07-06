
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ideal_playground/helpers/pick_image.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:ideal_playground/repositories/user_repository.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UserRepository _userRepository;

  EditProfileBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(EditProfileState.initial()) {
    on<LoadProfile>(_mapLoadProfileToState);
    on<NameChanged>(_mapNameChangedToState);
    on<PhoneChanged>(_mapPhoneChangedToState);
    on<CityChanged>(_mapCityChangedToState);
    on<StateChanged>(_mapStateChangedToState);
    on<CountryChanged>(_mapCountryChangedToState);
    on<PhotoUrlChanged>(_mapPhotoUrlChangedToState);
    on<InterestedInChanged>(_mapInterestedInChangedToState);
    on<UpdateProfile>(_mapUpdateProfileToState);
    on<IsMarriedChanged>(_mapIsMarriedChangedToState);
    on<IsOpenChanged>(_mapIsOpenChangedToState);
  }

  void _mapNameChangedToState(event, emit) {
    emit(state.update(name: event.name));
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

    final url = await PickImage.getImage();
    if(url == null) return;
    emit(state.update(filePhoto: url));
  }

  void _mapInterestedInChangedToState(event, emit) {
    emit(state.update(interestedIn: event.interestedIn));
  }

  void _mapUpdateProfileToState(event, emit) async {
    emit(state.loading());
    try {
      String uid = await _userRepository.getCurrentUserId();
      String url = state.user.photoUrl;
      if (state.filePhoto.isNotEmpty) {
        url = await _userRepository.uploadProfilePicture(uid, state.filePhoto);
      }
      if(url.isEmpty ){
        emit(state.failure());
        return;
      }
      await emit(state.update(photoUrl: url));
      await _userRepository.updateProfile(uid, state.user.toMap());

      emit(state.success());
    } catch (e) {
      emit(state.failure());
    }
  }

  void _mapIsMarriedChangedToState(event, emit) {
    emit(state.update(isMarried: event.isMarried));
  }

  void _mapIsOpenChangedToState(event, emit) {
    emit(state.update(isOpen: event.isOpen));
  }

  void _mapLoadProfileToState(event, emit) async {
    emit(state.loading());
    try {
      final UserModel user = await _userRepository.getUserDetails(event.uid);
      emit(state.updateUser(user: user));
    } catch (e) {
      emit(state.failure());
    }
  }
}
