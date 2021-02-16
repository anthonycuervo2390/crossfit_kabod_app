import 'package:crossfit_kabod_app/core/presentation/providers/providers.dart';
import 'package:crossfit_kabod_app/core/presentation/res/analytics.dart';
import 'package:crossfit_kabod_app/core/presentation/res/colors.dart';
import 'package:crossfit_kabod_app/features/drawer/oval_right_clipper.dart';
import 'package:crossfit_kabod_app/core/presentation/res/routes.dart';
import 'package:crossfit_kabod_app/features/results/screens/add_results.dart';
import 'package:crossfit_kabod_app/features/wods/presentation/pages/add_wod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crossfit_kabod_app/features/home/presentation/pages/home.dart';

class BuildDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Consumer(builder: (context, watch, _) {
        final user = watch(userRepoProvider).user;
        return Drawer(
          child: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 40),
            decoration: BoxDecoration(
                color: AppColors.scaffoldBackgroundColor,
                boxShadow: [BoxShadow(color: Colors.black45)]),
            width: 300,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 90,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [Colors.red, Colors.black])),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: user.photoUrl != null
                            ? NetworkImage(user.photoUrl)
                            : AssetImage(
                                "images/profile_image.jpg",
                              ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      user.name ?? 'Username',
                      style: TextStyle(
                          color: AppColors.labelColor, fontSize: 18.0),
                    ),
                    Text(
                      user?.email,
                      style: TextStyle(
                          color: AppColors.accentColorLight, fontSize: 16.0),
                    ),
                    SizedBox(height: 30.0),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, AppRoutes.home),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(children: [
                          Icon(
                            Icons.home,
                            color: AppColors.accentColorLight,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            "Today's WOD",
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 16.0),
                          ),
                        ]),
                      ),
                    ),
                    Divider(
                      color: AppColors.accentColorLight,
                    ),
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.profile),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(children: [
                          Icon(
                            Icons.person_pin,
                            color: AppColors.accentColorLight,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            "Class Schedule",
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 16.0),
                          ),
                        ]),
                      ),
                    ),
                    Divider(
                      color: AppColors.accentColorLight,
                    ),
                    InkWell(
                      onTap: () {
                        AddWodPage test = AddWodPage();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddResultPage(
                              selectedDate: test.selectedDate,
                              wod: test.wod,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(children: [
                          Icon(
                            Icons.settings,
                            color: AppColors.accentColorLight,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            "Add results",
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 16.0),
                          ),
                        ]),
                      ),
                    ),
                    Divider(
                      color: AppColors.accentColorLight,
                    ),
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.results),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(children: [
                          Icon(
                            Icons.table_rows,
                            color: AppColors.accentColorLight,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            "Whiteboard",
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 16.0),
                          ),
                        ]),
                      ),
                    ),
                    Divider(
                      color: AppColors.accentColorLight,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(children: [
                          Icon(
                            Icons.history,
                            color: AppColors.accentColorLight,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            "Performance History",
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 16.0),
                          ),
                        ]),
                      ),
                    ),
                    Divider(
                      color: AppColors.accentColorLight,
                    ),
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.bmiCalculator),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(children: [
                          Icon(
                            Icons.calculate,
                            color: AppColors.accentColorLight,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            "BMI Calculator",
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 16.0),
                          ),
                        ]),
                      ),
                    ),
                    Divider(
                      color: AppColors.accentColorLight,
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, AppRoutes.chat,
                          arguments: user.id),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(children: [
                          Icon(
                            Icons.chat,
                            color: AppColors.accentColorLight,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            "Kabod Chat",
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 16.0),
                          ),
                        ]),
                      ),
                    ),
                    Divider(
                      color: AppColors.accentColorLight,
                    ),
                    InkWell(
                      onTap: () {
                        logEvent(context, AppAnalyticsEvents.logOut);
                        context.read(userRepoProvider).signOut();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(children: [
                          Icon(
                            Icons.logout,
                            color: AppColors.accentColorLight,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            "Logout",
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 16.0),
                          ),
                        ]),
                      ),
                    ),
                    Divider(
                      color: AppColors.accentColorLight,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
