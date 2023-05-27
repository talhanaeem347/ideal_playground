import 'package:flutter/material.dart';
import 'package:ideal_playground/ui/pages/matches.dart';
import 'package:ideal_playground/ui/pages/messages.dart';
import 'package:ideal_playground/ui/pages/search.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class Tabs extends StatelessWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const Matches(),
      const Messages(),
      const Search(),
    ];

    return Theme(
      data: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.scaffoldBackgroundColor,
          foregroundColor: AppColors.yellow,
        ),
        primaryColor: AppColors.scaffoldBackgroundColor,
        hintColor: AppColors.yellow,
      ),
      child: DefaultTabController(
        length: pages.length,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(AppStrings.appName),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Image.asset("assets/dotted_menu.jpg"),
              ),
            ],
            bottom: TabBar(
              indicatorColor: AppColors.yellow,
              unselectedLabelColor: AppColors.white,
              labelColor: AppColors.yellow, // Set the icon color of the selected tab
              tabs: const [
                Tab(
                  icon: Icon(Icons.favorite),
                ),
                Tab(
                  icon: Icon(Icons.message),
                ),
                Tab(
                  icon: Icon(Icons.search),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: pages,
          ),
        ),
      ),
    );
  }
}