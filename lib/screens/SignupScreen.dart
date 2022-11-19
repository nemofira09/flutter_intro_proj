import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro_jamian_jade/models/ScreenArguments.dart';
import 'package:flutter_intro_jamian_jade/screens/Dashboard.dart';
import 'package:flutter_intro_jamian_jade/screens/LoginScreen.dart';
import 'package:flutter_intro_jamian_jade/services/AuthService.dart';
import '../widgets/CustomTextField.dart';
import '../widgets/PasswordField.dart';
import '../widgets/PrimaryButton.dart';
import 'package:flutter_intro_jamian_jade/provider.dart' as provider;

class SignupScreen extends StatefulWidget {
  static String routeName = "/signup";
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                      text: "Signup",
                      iconData: Icons.login,
                      onPress: signupValidation),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: Center(
                      child: GestureDetector(
                        onTap: loginNavigation,
                        child: const Text(
                            "Click here to go back to Login page.",
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
      title: const Text("Signup Alert"),
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

  signupValidation() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      alertText = "One of the fields is empty, please check";
      showAlertDialog(context);
    } else {
      try {
        setState(() {
          isLogginIn = true;
        });
        var user = _authService.signUp(emailController.text, passwordController.text);
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
  }

  loginWithProvider() async {
    
  }

  resetFields() async {
    emailController.text = passwordController.text = "";
  }

  loginNavigation() async {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }
}
