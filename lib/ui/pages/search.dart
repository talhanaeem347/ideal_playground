import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ideal_playground/bloc/search/search_bloc.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:ideal_playground/repositories/search_repository.dart';
import 'package:ideal_playground/ui/widgets/iconWidget.dart';
import 'package:ideal_playground/ui/widgets/profile.dart';
import 'package:ideal_playground/ui/widgets/userGender.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class Search extends StatefulWidget {
  final String userId;

  const Search({ required this.userId, Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final SearchRepository _searchRepository = SearchRepository();

  late SearchBloc _searchBloc;
   UserModel user = UserModel() , _currentUser = UserModel();
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
    _searchBloc = SearchBloc(searchRepository: _searchRepository)
      ..add(LoadUserEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider<SearchBloc>(
      create: (context) => _searchBloc,
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SearchLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SearchUserState) {
            user = state.user;
            _currentUser = state.currentUser;
            getDifferance(user.location);
            return profileWidget(
              size: size,
              photoUrl: user.photoUrl,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        userGender(user.gender),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${user.name.toUpperCase()}, ${DateTime.now().year - user.dateOfBirth.toUtc().year} years",
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: size.height * 0.04,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.yellow,
                          size: 28,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${differance / 1000} km away",
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: size.height * 0.03,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          iconWidget(
                              icon: EvaIcons.flash,
                              size: size.height * 0.04,
                              color: AppColors.yellow,
                              onTap: () {}),
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
                              icon: Icons.favorite,
                              size: size.height * 0.04,
                              color: AppColors.red,
                              onTap: () {
                                _searchBloc.add(
                                  SelectUserEvent(
                                      currentUserId: _currentUser.id,
                                      selectedUserId: user.id,
                                      name: _currentUser.name,
                                      photoUrl: _currentUser.photoUrl),
                                );
                              }),
                          iconWidget(
                              icon: Icons.line_style,
                              size: size.height * 0.04,
                              color: AppColors.black.withOpacity(0.9),
                              onTap: () {}),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );

          }
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

      ),
    );
  }
}
