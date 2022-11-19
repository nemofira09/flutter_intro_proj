import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro_jamian_jade/models/ScreenArguments.dart';
import 'package:flutter_intro_jamian_jade/screens/Dashboard.dart';
import 'package:flutter_intro_jamian_jade/screens/SignupScreen.dart';
import 'package:flutter_intro_jamian_jade/services/AuthService.dart';
import 'package:flutter_intro_jamian_jade/widgets/CustomTextField.dart';
import 'package:flutter_intro_jamian_jade/widgets/PasswordField.dart';
import 'package:flutter_intro_jamian_jade/widgets/PrimaryButton.dart';
import 'package:flutter_intro_jamian_jade/provider.dart' as provider;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService _authService  = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String alertText = "";
  bool obscurePassword = true;
  bool isLogginIn = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Center(
          child: ModalProgressHUD(
            inAsyncCall: isLogginIn,
            child: SingleChildScrollView(
                child: Center(
              child: Container(
                width: width * .85,
                child: Column(
                  children: [
                    CustomTextField(
                        labelText: "Email Address",
                        hintText: "Enter your email address",
                        controller: emailController,
                        textInputType: TextInputType.emailAddress),
                    const SizedBox(
                      height: 20.0,
                    ),
                    PasswordField(
                        obscureText: obscurePassword,
                        onTap: handleObscurePassword,
                        labelText: "Password",
                        hintText: "Enter your password",
                        controller: passwordController),
                    const SizedBox(
                      height: 20.0,
                    ),
                    PrimaryButton(
                        text: "Login",
                        iconData: Icons.login,
                        onPress: () {
                          loginWithProvider();
                          },
                        ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: Center(
                        child: GestureDetector(
                          onTap: signUpNavigation,
                          child: const Text(
                              "Don't have an account? Sign-up here.",
                              style: TextStyle(fontSize: 16.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Login Alert"),
      content: Text(alertText),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  handleObscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }
  //onPress: loginValidation
  /*loginValidation() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      alertText = "One of the fields is empty, please check";
      showAlertDialog(context);
    } else {
      User result = provider.UserList.holder.firstWhere(
          (x) =>
              x.emailAddress == emailController.text &&
              x.password == passwordController.text,
          orElse: () => User("", "", "", ""));
      if (result.emailAddress.isEmpty) {
        alertText = "Please check username or password. Login failed.";
        showAlertDialog(context);
      } else {
        //Insert dashboard navigator here.
        Navigator.pushReplacementNamed(context, Dashboard.routeName,
            arguments: ScreenArguments(emailController.text));
      }
    }
  }*/

  loginWithProvider() async {
    try {
      setState(() {
        isLogginIn = true;
      });
      var user = _authService.signIn(emailController.text, passwordController.text);
      // ignore: use_build_context_synchronously
      FirebaseAuth.instance.authStateChanges().listen((User? user) { 
        if(user != null){
          Navigator.pushReplacementNamed(context, Dashboard.routeName, arguments: ScreenArguments(emailController.text));
        }
      });
    } catch (e) {
      print(e.toString());
    }

    setState(() {
        isLogginIn = false;
    });
  }

  signUpNavigation() async {
    Navigator.pushReplacementNamed(context, SignupScreen.routeName);
  }
}
