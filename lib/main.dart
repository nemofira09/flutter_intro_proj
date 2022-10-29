import 'package:flutter/material.dart';
import 'package:flutter_intro_jamian_jade/routes.dart';
import 'package:flutter_intro_jamian_jade/screens/LoginScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: LoginScreen.routeName,
    routes: routes,
  ));
}
