import 'package:flutter/material.dart';
import 'package:newsapp/config/routes_name.dart';
import 'package:newsapp/repository/auth_repo.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            AuthRepository authRepository = AuthRepository();
            authRepository.logout();
            Navigator.pushReplacementNamed(context, RoutesName.loginRoute);
          },
          child: const Text("Log out")),
    );
  }
}
