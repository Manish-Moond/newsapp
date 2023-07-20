import 'package:flutter/material.dart';
import 'package:newsapp/constants/colors.dart';

class SignupHeader extends StatelessWidget {
const SignupHeader({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          "Sign up",
          style: TextStyle(
              color: kPrimaryColor,
              fontSize: 28,
              fontFamily: 'poppins',
              fontWeight: FontWeight.bold),
        ),
         Text(
          "Sign up to live in your dream",
          style: TextStyle(
              color: kGreyColor,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: size.height * 0.02,
        )
      ],
    );
  }
}