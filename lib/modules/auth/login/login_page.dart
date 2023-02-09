import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login-page';
  const LoginPage({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Login Page')),
    );
  }
}
