
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ideal_playground/bloc/search/search_bloc.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:ideal_playground/repositories/search_repository.dart';
import 'package:ideal_playground/ui/widgets/custom/toses.dart';
import 'package:ideal_playground/ui/widgets/profile.dart';

class Search extends StatefulWidget {

  const Search({ Key? key}) :
        super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final SearchRepository _userRepository = SearchRepository();

  get _userId => "1234";
  late SearchBloc _searchBloc;
  late UserModel user, _currentUser;
  int differance = 0;

  getDifferance(GeoPoint userLocation) async {
    final currentLocation = await Geolocator.getCurrentPosition();
    differance = Geolocator.distanceBetween(
            userLocation.latitude,
            userLocation.longitude,
            currentLocation.latitude,
            currentLocation.longitude)
        .toInt();
  }

  @override
  void initState() {
    _searchBloc = SearchBloc(searchRepository: _userRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state is SearchInitialState) {
        _searchBloc.add(LoadUserEvent(userId: _userId));
        showCircularProgress(context);
      }
      if(state is SearchLoadingState){
        showCircularProgress(context);
      }
      if(state is SearchUserState)
      {
        user = state.user;
        _currentUser = state.currentUser;
        getDifferance(user.location);
      }
      return profileWidget(
        size: size,
        photoUrl: user.photoUrl,
        child: const Text("Hello"),
      );
    });
  }
}
