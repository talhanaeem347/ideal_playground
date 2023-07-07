import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/user_profile/user_profile_bloc.dart';
import 'package:ideal_playground/repositories/user_repository.dart';
import 'package:ideal_playground/ui/pages/edit_profile.dart';
import 'package:ideal_playground/ui/widgets/custom/CustomListTile.dart';
import 'package:ideal_playground/ui/widgets/page_turn.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';
import 'package:intl/intl.dart';


class UserProfile extends StatefulWidget {
  final String userId;

  const UserProfile({super.key, required this.userId});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late UserRepository _userRepository;
  late UserProfileBloc _userProfileBloc;

  String get _userId => widget.userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userRepository = UserRepository();
    _userProfileBloc = UserProfileBloc(userRepository: _userRepository);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener(
      bloc: _userProfileBloc,
      listener: (context, state) {
        if (state is UserProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },

      child: BlocProvider(
        create: (context) => _userProfileBloc,
        child: BlocBuilder(
          bloc: _userProfileBloc,
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("My Profile"),
                centerTitle: true,
              ),

              body: Container(
                padding: const EdgeInsets.all(10),
                child: state is UserProfileInitial
                    ? () {
                        _userProfileBloc.add(LoadUserProfile(userId: _userId));
                        return const Center(child: CircularProgressIndicator());
                      }()
                    : state is UserProfileLoading
                        ? const Center(child: CircularProgressIndicator())
                        : state is UserProfileLoaded
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: size.width * 0.05,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: size.width * 0.15,
                                        backgroundImage:
                                            NetworkImage(state.user.photoUrl),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.05,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(state.user.name,
                                              style: TextStyle(
                                                  fontSize: size.width * 0.06,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: size.width * 0.02,
                                          ),
                                          Text(state.user.email,
                                              style: TextStyle(
                                                  fontSize: size.width * 0.04,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.width * 0.05,
                                  ),
                                  CustomListTile(
                                    leadingIcon: Icons.call,
                                    title: state.user.phone,
                                    size: size,
                                    leadingColor: AppColors.green,
                                  ),
                                  SizedBox(
                                    height: size.width * 0.05,
                                  ),
                                  CustomListTile(
                                    leadingIcon: Icons.house_outlined,
                                    title: "${state.user.city}, ${state.user.state}, ${state.user.country}",
                                    size: size,
                                    leadingColor: AppColors.blue,
                                  ),
                                  SizedBox(
                                    height: size.width * 0.05,
                                  ),
                                  CustomListTile(
                                    leadingIcon: Icons.cake,
                                    title: DateFormat('dd MMM yyyy').format(state.user.dateOfBirth),

                                    size: size,
                                    leadingColor: AppColors.yellow,
                                  ),
                                  SizedBox(
                                    height: size.width * 0.05,
                                  ),
                                  CustomListTile(leadingIcon: Icons.accessibility_new ,title: state.user.gender, size: size,leadingColor: AppColors.yellow),
                                  SizedBox(
                                    height: size.width * 0.05,
                                  ),
                                  CustomListTile(leadingIcon: Icons.handshake_outlined ,title: state.user.interestedIn, size: size,leadingColor: AppColors.yellow),
                                  SizedBox(
                                    height: size.width * 0.05,
                                  ),
                                  CustomListTile(
                                    leadingIcon: Icons.edit,
                                    title: "Edit Profile",
                                    size: size,
                                    leadingColor: AppColors.yellow,
                                    onTap: () {
                                      pageTurn(context: context, page: EditProfileScreen(userRepository: _userRepository,uid:_userId ,));
                                    },
                                    trailingIcon: Icons.arrow_forward_ios,
                                  ),
                                ],
                              )
                            : const Center(
                                child: Text("Error loading profile")),
              ),
            );
          },
        ),
      ),
    );
  }
}
