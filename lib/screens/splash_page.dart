import 'package:flutter/material.dart';
import 'package:newsapp/config/routes_name.dart';
import 'package:newsapp/constants/colors.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _checkUserLoggedInOrNot() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    bool val = sp.getBool("isLoggedin") ?? false;
    Future.delayed(const Duration(seconds: 2), () {
      if (!val) {
        Navigator.pushReplacementNamed(context, RoutesName.loginRoute);
      } else {
        Navigator.pushReplacementNamed(context, RoutesName.dashboardRoute);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _checkUserLoggedInOrNot();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
                height: 200,
                child: RiveAnimation.asset(
                    'assets/animation/news_splash_animation.riv')),
            const SizedBox(height: 50),
            Text(
              "NEWS",
              style: TextStyle(
                  fontSize: 32,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text:
                    "News is the lifeblood of democracy. Without it, a society is blind, deaf, and disconnected from the world. - ",
                style: TextStyle(color: Colors.grey[700]),
              ),
              TextSpan(
                  text: "Walter Cronkite",
                  style: TextStyle(color: Colors.blue[300]))
            ]))
          ],
        ),
      )),
    );
  }
}
