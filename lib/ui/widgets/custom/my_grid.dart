import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ideal_playground/bloc/matchies/matches_bloc.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:ideal_playground/repositories/match_repository.dart';
import 'package:ideal_playground/ui/widgets/profile_dilog.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

late int differance;

Widget myGridView({
  required Size size,
  required Stream<QuerySnapshot> list,
  required String userId,
  required String emptyText,
  required MatchRepository matchRepository,
  required MatchesBloc matchesBloc,
}) {
  return StreamBuilder<QuerySnapshot>(
      stream: list,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(emptyText,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            );
          }
          final users = snapshot.data!.docs;
          return GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (var i = 0; i < snapshot.data!.docs.length; i++)
                Container(
                  padding: const EdgeInsets.all(4 ),
                  child: GestureDetector(
                    onTap: () async {
                      UserModel user = await matchRepository.getUserDetails(
                          userId: users[i].id);
                      UserModel currentUser =
                          await matchRepository.getUserDetails(userId: userId);
                      await getDifferance(user.location);
                      profileDialog(
                        context: context,
                        size: size,
                        user: user,
                        differance: differance,
                        isMatched: emptyText.contains("Matches") ,
                        matchesBloc: matchesBloc,
                        currentUser: currentUser,
                      );
                    },
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(
                                snapshot.data!.docs[i]["photoUrl"],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(snapshot.data!.docs[i]["name"],
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        }
        return const Center(
          child: Text("data found",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
        );
      });
}

Future<void> getDifferance(GeoPoint userLocation) async {
  final currentLocation = await Geolocator.getCurrentPosition();
  differance = Geolocator.distanceBetween(
    userLocation.latitude,
    userLocation.longitude,
    currentLocation.latitude,
    currentLocation.longitude,
  ).toInt();
}
