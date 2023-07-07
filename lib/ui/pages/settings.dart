import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/authentication/authentication_bloc.dart';
import 'package:ideal_playground/bloc/settings/settings_bloc.dart';
import 'package:ideal_playground/bloc/theme/theme_bloc.dart';
import 'package:ideal_playground/helpers/theme_helper.dart';
import 'package:ideal_playground/repositories/settings_repository.dart';
import 'package:ideal_playground/ui/pages/user_profile.dart';
import 'package:ideal_playground/ui/widgets/custom/CustomListTile.dart';
import 'package:ideal_playground/ui/widgets/custom/simple_button.dart';
import 'package:ideal_playground/ui/widgets/page_turn.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class Settings extends StatefulWidget {
  final String userId;

  const Settings({super.key, required this.userId});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final SettingsRepository _settingsRepository = SettingsRepository();
  late SettingsBloc _settingsBloc;
  bool isDark = ThemeHelper.isDarkModeOn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _settingsBloc = SettingsBloc(settingsRepository: _settingsRepository);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<SettingsBloc, SettingsState>(
        bloc: _settingsBloc,
        builder: (context, state) {
          if (state is SettingsInitial) {
            _settingsBloc.add(LoadSettings(userId: widget.userId));
            return Container(
                color: AppColors.scaffoldBackgroundColor,
                child: const Center(
                  child: CircularProgressIndicator(),
                ));
          }
          if (state is SettingsLoading) {
            return Container(
                color: AppColors.scaffoldBackgroundColor,
                child: const Center(
                  child: CircularProgressIndicator(),
                ));
          }
          if (state is SettingsLoaded) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor:
                      AppColors.scaffoldBackgroundColor.withOpacity(0.8),
                  foregroundColor: AppColors.yellow,
                  centerTitle: true,
                  title: Text(
                    AppStrings.settings,
                    style: TextStyle(fontSize: size.width * 0.08),
                  ),
                ),
                body: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      CustomListTile(
                        title: AppStrings.profile,
                        size: size,
                        leadingImage: state.photoUrl,
                        trailingIcon: Icons.arrow_forward_ios,
                        onTap: () => pageTurn(
                            context: context,
                            page: UserProfile(userId: widget.userId)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomListTile(
                        title: "Dark Mode",
                        size: size,
                        leadingIcon: Icons.light_mode_rounded,
                        trailing: Switch(
                          value: state.isDarkMode,
                          onChanged: (value) {
                            _settingsBloc.add(UpdateDarkMode(
                                userId: widget.userId, isDarkMode: value));
                            BlocProvider.of<ThemeBloc>(context)
                                .add(ThemeToggleEvent(isDarkMode: value));
                          },
                          activeColor: AppColors.yellow,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: SimpleButton(
                            height: 50,
                            textColor: AppColors.white,
                            onPressed: () {
                              BlocProvider.of<AuthenticationBloc>(context)
                                  .add(LoggedOut());
                              Navigator.pop(context);
                            },
                            color: AppColors.yellow,
                            label: "Logout",
                            width: size.width * 0.4),
                      )
                    ],
                  ),
                ));
          }
          return Center(child: Text(AppStrings.failureMessage));
        });
  }
}
