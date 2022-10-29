import 'package:flutter/cupertino.dart';
import 'package:flutter_intro_jamian_jade/screens/LoginScreen.dart';
import 'package:flutter_intro_jamian_jade/screens/SignupScreen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (BuildContext context) => LoginScreen(),
  SignupScreen.routeName: (BuildContext context) => SignupScreen()
};