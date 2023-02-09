import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const routeName = '/register-page';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Register Page'),),
    );
  }
}
