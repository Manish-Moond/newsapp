import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/config/routes_name.dart';
import 'package:newsapp/constants/colors.dart';
import 'package:newsapp/repository/auth_repo.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool passToggle = true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter name";
              }
              return null;
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor)),
              border:
                  OutlineInputBorder(borderSide: BorderSide(color: kGreyColor)),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
              labelText: 'Name',
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value!.isEmpty ||
                  !RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-]+)(\.[a-zA-Z]{2,5}){1,2}$')
                      .hasMatch(value)) {
                return "Enter a valid email";
              }
              return null;
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor)),
              border:
                  OutlineInputBorder(borderSide: BorderSide(color: kGreyColor)),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
              labelText: 'Email',
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            obscureText: passToggle,
            validator: (value) {
              if (value!.length < 6) {
                return "Password must be atleast 6 chr";
              }
              return null;
            },
            controller: _passwordController,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    passToggle = !passToggle;
                  });
                },
                child: Icon(passToggle
                    ? FluentIcons.eye_off_20_regular
                    : FluentIcons.eye_20_regular),
              ),
              labelText: 'Password',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor)),
              border:
                  OutlineInputBorder(borderSide: BorderSide(color: kGreyColor)),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
            ),
          ),
          const SizedBox(height: 16.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text("Forgot password?")],
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                AuthRepository authRepository = AuthRepository();
                authRepository
                    .createAccount(_emailController.text.toString(),
                        _passwordController.text.toString())
                    .then((value) => Navigator.pushReplacementNamed(
                        context, RoutesName.dashboardRoute));
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                minimumSize: Size(size.width, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                )),
            child: const Text(
              'SignUp',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
