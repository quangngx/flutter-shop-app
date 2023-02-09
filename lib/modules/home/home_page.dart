import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home-page';

  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
