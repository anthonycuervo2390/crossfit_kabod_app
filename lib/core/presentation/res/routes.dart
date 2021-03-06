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

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings,
        builder: (_) {
          switch (settings.name) {
            case results:
              return ResultsPage();
            case addResult:
              return AddResultPage(selectedDate: settings.arguments);
            case addWod:
              return AddWodPage(
                  selectedDate: settings
                      .arguments); //TODO esto sirve para pasar un argumento de una pagina a otra, ver detalles en Home
            case editWod:
              return AddWodPage(
                  wod: settings
                      .arguments); //TODO: cuando vayamos a la ruta editWod nos enviara a AddWod pero esta vez le pasamos como argumento el wod seleccionado para que lo muestre y lo podamos editar
            case viewWod:
              return WodDetails(wod: settings.arguments);
            case home:
              return AuthHomePage();
            case resetPassword:
              return ResetPassword();
            case userInfo:
              return UserInfoPage();
            case editProfile:
              return EditProfile(
                user: settings.arguments,
              );
            case profile:
              return UserProfile();
            case splash:
            default:
              return Splash();
          }
        });
  }
}
