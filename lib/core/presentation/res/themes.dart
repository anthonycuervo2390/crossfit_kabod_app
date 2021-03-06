import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crossfit_kabod_app/core/presentation/res/colors.dart';
import 'package:crossfit_kabod_app/core/presentation/res/sizes.dart';

class AppThemes {
  static BuildContext context;
  static final ThemeData defaultTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    primaryColor: AppColors.primaryColor,
    accentColor: AppColors.primaryColor,
    primarySwatch: Colors.red,
    buttonColor: AppColors.primaryColor,
    appBarTheme: AppBarTheme(
      color: AppColors.scaffoldBackgroundColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.redAccent,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
  );
}
