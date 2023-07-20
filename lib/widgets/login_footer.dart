import 'package:flutter/material.dart';
import 'package:newsapp/config/routes_name.dart';
import 'package:newsapp/constants/colors.dart';
import 'package:newsapp/repository/auth_repo.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(children: [
      SizedBox(
        height: size.height * 0.02,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              indent: 20.0,
              endIndent: 10.0,
              thickness: 1,
              color: kGreyColor,
            ),
          ),
          Text(
            "OR",
            style: TextStyle(
              color: kGreyColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Divider(
              indent: 10.0,
              endIndent: 20.0,
              thickness: 1,
              color: kGreyColor,
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 24,
      ),
      InkWell(
        onTap: () {
          AuthRepository authRepository = AuthRepository();
          authRepository.signInWithGoogle().then((value) =>
              Navigator.pushReplacementNamed(
                  context, RoutesName.dashboardRoute));
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Log in with Google",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins"),
            ),
            Image(
              image: AssetImage("assets/images/googleLogo.png"),
              height: 28,
            )
          ],
        ),
      ),
      const SizedBox(
        height: 16,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(color: kGreyColor, fontFamily: "Poppins"),
          ),
          TextButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, RoutesName.signUpRoute);
            },
            style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
            child: const Text(
              "Sign up",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  fontFamily: "Poppins"),
            ),
          ),
        ],
      )
    ]);
  }
}
