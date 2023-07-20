import 'package:flutter/material.dart';
import 'package:newsapp/widgets/login_footer.dart';
import 'package:newsapp/widgets/login_form.dart';
import 'package:newsapp/widgets/login_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 200),
            const LoginHeader(),
            const LoginForm(),
            const LoginFooter()
          ],
        ),
      ),
    ));
  }
}
