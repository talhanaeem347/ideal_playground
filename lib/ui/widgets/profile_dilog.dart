import 'package:flutter/material.dart';
import 'package:ideal_playground/bloc/matchies/matches_bloc.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:ideal_playground/ui/pages/chat_room.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

import 'iconWidget.dart';
import 'profile.dart';
import 'userGender.dart';

void profileDialog(
    {required BuildContext context, required Size size, required UserModel user, required int differance, required bool isMatched, required MatchesBloc matchesBloc, required UserModel currentUser}) {
  showDialog(
      context: context,
      builder: (context) {
        return Material(
          child: profileWidget(
            size: size,
            photoUrl: user.photoUrl,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                        "${user.name.toUpperCase()}, ${DateTime
                            .now()
                            .year - user.dateOfBirth
                            .toUtc()
                            .year} years",
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: [
                        isMatched ? iconWidget(
                            icon: Icons.chat,
                            size: size.height * 0.04,
                            color: AppColors.yellow,
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatRoom(
                                    userId: currentUser.id,
                                    matchId: user.id,
                                  ),
                                ),
                              );
                                 matchesBloc.add(
                                        MatchesOpenChatEvent(
                                          currentUserId: currentUser.id,
                                          selectedUserId: user.id,
                                        ));
                                 Navigator.pop(context);
                            })
                            : iconWidget(
                            icon: Icons.clear,
                            size: size.height * 0.04,
                            color: AppColors.blue,
                            onTap: () {
                              matchesBloc.add(
                                  MatchesDeleteUserEvent(
                                    currentUserId: currentUser.id,
                                    selectedUserId: user.id,
                                  ));
                              Navigator.pop(context);
                            }),
                        isMatched ? iconWidget(
                            icon: Icons.call_rounded,
                            size: size.height * 0.04,
                            color: AppColors.green,
                            onTap: () {
                              matchesBloc.add(
                                  MatchesOpenCallEvent(
                                    currentUserId: currentUser.id,
                                    selectedUserId: user.id,
                                  ));
                              Navigator.pop(context);
                            })
                            : iconWidget(
                            icon: Icons.favorite,
                            size: size.height * 0.04,
                            color: AppColors.red,
                            onTap: () {
                              matchesBloc.add(
                                  MatchesAcceptUserEvent(
                                    currentUser: currentUser,
                                    selectedUser: user,
                                  ));
                              Navigator.pop(context);
                            }),

                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}