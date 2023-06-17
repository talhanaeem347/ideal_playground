
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ideal_playground/bloc/matchies/matches_bloc.dart';
import 'package:ideal_playground/repositories/match_repository.dart';
import 'package:ideal_playground/ui/widgets/custom/my_grid.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

Widget matchesGrid(
    {
      required BuildContext context,
      required Size size,
      required Stream<QuerySnapshot> list,
      required String userId,
      required MatchRepository matchRepository,
      required MatchesBloc matchesBloc,
    }) {
  return Column(
    children: [
      SizedBox(
        height: size.height * 0.01,
      ),
      Container(
        alignment: Alignment.center,
        width: size.width,
        height: size.height * 0.06,
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackgroundColor,
        ),
        child: Text(
          "Matches",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(
        height: size.height * 0.01,
      ),
      myGridView(
        matchRepository: matchRepository,
          matchesBloc: matchesBloc,
          size: size,
          list: list,
          userId: userId,
          emptyText: "No Matches",
      ),
    ],
  );
}
