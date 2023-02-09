import 'package:flutter/material.dart';
import 'package:flutter_shop_app/modules/auth/login/login_page.dart';
import 'package:flutter_shop_app/modules/home/home_page.dart';

final Map<String, WidgetBuilder> authorizedRoutes = {
  HomePage.routeName: (context) => const HomePage(),
  '/error_page': (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Coming soon'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      ),
};

final Map<String, WidgetBuilder> unauthorizedRoutes = {
  LoginPage.routeName: (context) => const LoginPage(),
  '/error_page': (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Coming soon'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      ),
};

MaterialPageRoute<dynamic>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    default:
      return null;
  }
}
