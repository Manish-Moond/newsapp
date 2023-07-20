import 'package:flutter/material.dart';
import 'package:newsapp/config/routes_name.dart';
import 'package:newsapp/constants/colors.dart';

class SignupFooter extends StatefulWidget {
  const SignupFooter({Key? key}) : super(key: key);

  @override
  _SignupFooterState createState() => _SignupFooterState();
}

class _SignupFooterState extends State<SignupFooter> {
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
        onTap: () {},
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Signup with Google",
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
            "Already have an account",
            style: TextStyle(color: kGreyColor, fontFamily: "Poppins"),
          ),
          TextButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, RoutesName.loginRoute);
            },
            style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
            child: const Text(
              "Login",
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
