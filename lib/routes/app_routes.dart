import 'package:flutter/material.dart';
import 'package:project/presentation/Home.dart';
import 'package:project/presentation/firstPage.dart';


class AppRoutes {
  static const String splashScreen = '/splash';
  static const String loginScreen = '/login';
  static const String signUpScreen = '/signup';
  static const String dashboard = '/dashboard';
  static const String events = '/event';
  static const String addEvent = '/addEvent';
  static const String homeScreen = '/home';
  static const String profileScreen = '/profile';
  static const String firstScreen = '/first'; // Add the route for FirstPage

  static Map<String, WidgetBuilder> routes = {
 homeScreen: (context) => Home(),
    firstScreen: (context) => FirstPage(), // Set FirstPage as the first screen
  };
}
