import 'package:flutter/material.dart';
import 'package:ideal_playground/ui/pages/matches.dart';
import 'package:ideal_playground/ui/pages/messages.dart';
import 'package:ideal_playground/ui/pages/search.dart';
import 'package:ideal_playground/ui/pages/settings.dart';
import 'package:ideal_playground/ui/widgets/page_turn.dart';
import 'package:ideal_playground/utils/constants/app_Strings.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class Tabs extends StatelessWidget {
  final String _userId;

  const Tabs({required userId, Key? key})
      : _userId = userId,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Search(userId: _userId),
      Matches(userId: _userId),
      Messages(userId: _userId),
    ];

    return  DefaultTabController(
        length: pages.length,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(AppStrings.appName,),
            actions: [
              IconButton(
                onPressed: () {
                  pageTurn(context: context, page: Settings(userId:_userId));

                },
                icon: Image.asset("assets/dotted_menu.jpg"),
              ),
            ],
            bottom: TabBar(
              indicatorColor: AppColors.yellow,
              unselectedLabelColor: AppColors.white,
              labelColor: AppColors.yellow,
              // Set the icon color of the selected tab
              tabs: const [
                Tab(
                  icon: Icon(Icons.search),
                ),
                Tab(
                  icon: Icon(Icons.favorite),
                ),
                Tab(
                  icon: Icon(Icons.message),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: pages,
          ),
        ),
      
    );
  }
}
