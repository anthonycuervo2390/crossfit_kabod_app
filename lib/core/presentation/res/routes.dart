import 'package:crossfit_kabod_app/features/bmiCalculator/presentation/pages/input_page.dart';
import 'package:crossfit_kabod_app/features/bmiCalculator/presentation/pages/result_page.dart';
import 'package:crossfit_kabod_app/features/chat/presentation/pages/home.dart';
import 'package:crossfit_kabod_app/features/results/screens/add_results.dart';
import 'package:crossfit_kabod_app/features/wods/presentation/pages/add_wod.dart';
import 'package:crossfit_kabod_app/features/results/screens/results.dart';
import 'package:crossfit_kabod_app/features/wods/presentation/pages/view_wod_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:crossfit_kabod_app/features/auth/presentation/pages/home.dart';
import 'package:crossfit_kabod_app/features/auth/presentation/pages/splash.dart';
import 'package:crossfit_kabod_app/features/auth/presentation/pages/user_info.dart';
import 'package:crossfit_kabod_app/features/profile/presentation/pages/edit_profile.dart';
import 'package:crossfit_kabod_app/features/profile/presentation/pages/profile.dart';
import 'package:crossfit_kabod_app/features/auth/presentation/pages/forgot_password.dart';

class AppRoutes {
  static const home = "/";
  static const splash = "splash";
  static const login = "login";
  static const signup = "signup";
  static const resetPassword = "reset_password";
  static const userInfo = "user_info";
  static const String profile = "profile";
  static const String editProfile = "edit_profile";
  static const String addWod = "add_wod";
  static const String editWod = "edit_wod";
  static const String viewWod = "view_wod";
  static const String addResult = "add_result";
  static const String results = "results";
  static const String bmiCalculator = "bmi_calculator";
  static const String bmiResults = "bmi_results";
  static const String chat = "chat";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings,
        builder: (_) {
          switch (settings.name) {
            case chat:
              return ChatHomeScreen(currentUserId: settings.arguments);
            case bmiCalculator:
              return BmiCalculatorPage();
            case bmiResults:
              return BmiResultPage(
                  bmiResult: settings.arguments,
                  interpretation: settings.arguments,
                  resultText: settings.arguments);
            case results:
              return ResultsPage();
            case addResult:
              return AddResultPage(selectedDate: settings.arguments);
            case addWod:
              return AddWodPage(selectedDate: settings.arguments);
            case editWod:
              return AddWodPage(wod: settings.arguments);
            case viewWod:
              return WodDetails(wod: settings.arguments);
            case home:
              return AuthHomePage();
            case resetPassword:
              return ResetPassword();
            case userInfo:
              return UserInfoPage();
            case editProfile:
              return EditProfile(user: settings.arguments);
            case profile:
              return UserProfile();
            case splash:
            default:
              return Splash();
          }
        });
  }
}
