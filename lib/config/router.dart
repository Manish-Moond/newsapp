import 'package:flutter/material.dart';
import 'package:newsapp/screens/account_page.dart';
import 'package:newsapp/screens/chat_page.dart';
import 'package:newsapp/config/routes_name.dart';
import 'package:newsapp/dashboard.dart';
import 'package:newsapp/screens/home_page.dart';
import 'package:newsapp/screens/login_page.dart';
import 'package:newsapp/screens/saved_page.dart';
import 'package:newsapp/screens/signup_page.dart';
import 'package:newsapp/screens/splash_page.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesName.splashRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashPage());

      case RoutesName.loginRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage());

      case RoutesName.signUpRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignupPage());

      case RoutesName.dashboardRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DashBoard());

      case RoutesName.homeRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomePage());

      case RoutesName.savedRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SavedPage());

      case RoutesName.chatRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ChatPage());

      case RoutesName.accountRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AccountPage());

      default:
    }
    return null;
  }
}
