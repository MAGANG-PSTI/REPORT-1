import 'package:flutter/material.dart';
import 'package:pkl_demeter_mobile/auth/screens/login_page.dart';

Route<void> generateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case (LoginPage.screenName):
      return _pageRoute(routesName: "/login", routesView: LoginPage());

    default:
      return MaterialPageRoute(
          builder: (context) => Scaffold(
              body: Center(
                  child: Text(
                      "No corresponding ${routeSettings.name} is found."))));
  }
}

PageRoute _pageRoute({String? routesName, Widget? routesView}) {
  return MaterialPageRoute(
      settings: RouteSettings(name: routesName), builder: (ctx) => routesView!);
}
