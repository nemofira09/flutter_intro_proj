import 'package:flutter/material.dart';
import 'package:flutter_intro_jamian_jade/screens/Settings.dart';
import 'package:flutter_intro_jamian_jade/provider.dart' as provider;

import '../models/ScreenArguments.dart';

class Dashboard extends StatefulWidget {
  static String routeName = "/dashboard";

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
      //var args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
      var email = provider.LocalStorage.localStorage?.getString('emailVal');
      var uid = provider.LocalStorage.localStorage?.getString('UIDVal');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to Dashboard"),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Settings.routeName);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.settings,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Text("Email: $email, \nUID: $uid", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
//${args.message}, $uid
