import 'package:flutter/material.dart';
import 'package:flutter_intro_jamian_jade/screens/LoginScreen.dart';
import 'package:flutter_intro_jamian_jade/services/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_intro_jamian_jade/provider.dart' as provider;

class Settings extends StatefulWidget {
  static String routeName = "/settings";

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () async {
              await _authService.logout();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginScreen.routeName, (Route<dynamic> route) => false);
                  provider.LocalStorage.localStorage!.clear();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.logout,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Text("Welcome to Settings!", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
