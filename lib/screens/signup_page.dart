import 'package:flutter/material.dart';
import 'package:newsapp/widgets/signup_footer.dart';
import 'package:newsapp/widgets/signup_form.dart';
import 'package:newsapp/widgets/signup_header.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(28, 0, 28, 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 200),
              const SignupHeader(),
              const SignupForm(),
              const SignupFooter()
            ],
          ),
        ),
      ),
    );
  }
}
