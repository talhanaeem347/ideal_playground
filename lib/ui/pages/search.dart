//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ideal_playground/bloc/search/search_bloc.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:ideal_playground/repositories/search_repository.dart';
import 'package:ideal_playground/ui/widgets/custom/toses.dart';
import 'package:ideal_playground/ui/widgets/iconWidget.dart';
import 'package:ideal_playground/ui/widgets/profile.dart';
import 'package:ideal_playground/ui/widgets/userGender.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class Search extends StatefulWidget {
  final userId;

  const Search({this.userId, Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final SearchRepository _searchRepository = SearchRepository();

  late SearchBloc _searchBloc;
  late UserModel user, _currentUser;
  int differance = 0;

  Future<void> getDifferance(GeoPoint userLocation) async {
    final currentLocation = await Geolocator.getCurrentPosition();
    differance = Geolocator.distanceBetween(
      userLocation.latitude,
      userLocation.longitude,
      currentLocation.latitude,
      currentLocation.longitude,
    ).toInt();
  }

  @override
  void initState() {
    super.initState();
    SearchBloc(searchRepository: _searchRepository)
        .add(LoadUserEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(searchRepository: _searchRepository),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SearchLoadingState) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SearchUserState) {
            user = state.user;
            _currentUser = state.currentUser;
            getDifferance(user.location);
          }
          if (user.location == null) {
            return Center(
              child: Text(
                "No One Here",
                style: TextStyle(
                    color: AppColors.yellow,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            );
          }
          return profileWidget(
            size: size,
            photoUrl: user.photoUrl,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        userGender(user.gender),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${user.name}, ${DateTime.now().year - user.dateOfBirth.toUtc().year}",
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.yellow,
                        ),
                        Text(
                          "${differance / 1000} km away",
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        iconWidget(
                            icon: EvaIcons.flash,
                            size: size.height * 0.04,
                            color: AppColors.yellow,
                            onTap: () {
                              print("Flash");
                            }),
                        iconWidget(
                            icon: Icons.clear,
                            size: size.height * 0.04,
                            color: AppColors.blue,
                            onTap: () {
                              _searchBloc.add(PassUserEvent(
                                  currentUserId: _currentUser.id,
                                  selectedUserId: user.id));
                            }),
                        iconWidget(
                            icon: FontAwesomeIcons.solidHeart,
                            size: size.height * 0.04,
                            color: AppColors.red,
                            onTap: () {
                              _searchBloc.add(
                                SelectUserEvent(
                                    currentUserId: _currentUser.id,
                                    selectedUserId: user.id,
                                    name: user.name,
                                    photoUrl: user.photoUrl),
                              );
                              print("Favorite");
                            }),
                        iconWidget(
                            icon: EvaIcons.flash,
                            size: size.height * 0.04,
                            color: AppColors.yellow,
                            onTap: () {
                              print("Flash");
                            }),
                      ],
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }
}
