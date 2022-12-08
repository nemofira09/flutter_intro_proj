import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro_jamian_jade/routes.dart';
import 'package:flutter_intro_jamian_jade/screens/Dashboard.dart';
import 'package:flutter_intro_jamian_jade/screens/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_intro_jamian_jade/provider.dart' as provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  provider.LocalStorage.init();
  String check = provider.LocalStorage.localStorage?.getString('emailVal') ?? 'empty';
  if(check != 'empty'){
    runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: LoginScreen.routeName,
    routes: routes,
  ));
  }else{
    runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Dashboard.routeName,
    routes: routes,
  ));
  }
}
