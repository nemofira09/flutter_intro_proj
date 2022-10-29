import 'package:flutter/material.dart';
import 'package:flutter_intro_jamian_jade/screens/SignupScreen.dart';
import 'package:flutter_intro_jamian_jade/widgets/CustomTextField.dart';
import 'package:flutter_intro_jamian_jade/widgets/PasswordField.dart';
import 'package:flutter_intro_jamian_jade/widgets/PrimaryButton.dart';
import 'package:flutter_intro_jamian_jade/models/User.dart';
import 'package:flutter_intro_jamian_jade/provider.dart' as provider;

class LoginScreen extends StatefulWidget{
  static String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String alertText = "";
  bool obscurePassword = true;
  
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
                    PrimaryButton(text: "Login", iconData: Icons.login, onPress: loginValidation),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: Center(
                        child: GestureDetector(
                          onTap: signUpNavigation,
                          child: const Text("Don't have an account? Sign-up here.", style: TextStyle(
                            fontSize: 16.0
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
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

  loginValidation() async {
    if(emailController.text.isEmpty || passwordController.text.isEmpty){
      alertText = "One of the fields is empty, please check";
      showAlertDialog(context); 
    }else{
    User result = provider.UserList.holder.firstWhere((x) => x.emailAddress == emailController.text && x.password == passwordController.text, orElse: () => User("","","",""));
    if(result.emailAddress.isEmpty){
      alertText = "Please check username or password. Login failed.";
      showAlertDialog(context); 
    }else{
      alertText = "LOGIN SUCCESS!";
      showAlertDialog(context); 
      //Insert dashboard navigator here.
    }
    }
  }

  signUpNavigation() async {
    Navigator.pushNamed(context, SignupScreen.routeName);
  }
} 