import 'package:flutter/material.dart';
import 'package:flutter_intro_jamian_jade/models/User.dart';
import 'package:flutter_intro_jamian_jade/screens/LoginScreen.dart';
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
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
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
                        labelText: "First Name", 
                        hintText: "Enter your First Name", 
                        controller: firstNameController, 
                        textInputType: TextInputType.name),
                    const SizedBox(
                      height: 20.0,
                      ),
                    CustomTextField(
                        labelText: "Last Name", 
                        hintText: "Enter your Last Name", 
                        controller: lastNameController, 
                        textInputType: TextInputType.name),
                    const SizedBox(
                      height: 20.0,
                      ),
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
                    PasswordField(
                        obscureText: obscurePassword, 
                        onTap: handleObscurePassword, 
                        labelText: "Confirm Password", 
                        hintText: "Enter your password again", 
                        controller: confirmPasswordController),
                    const SizedBox(
                      height: 20.0,
                    ),
                    PrimaryButton(text: "Signup", iconData: Icons.login, onPress: signupValidation),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: Center(
                        child: GestureDetector(
                          onTap: loginNavigation,
                          child: const Text("Click here to go back to Login page.", style: TextStyle(
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
    title: const Text("Signup Alert"),  
    content:  Text(alertText),  
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
    if(firstNameController.text.isEmpty || lastNameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty || confirmPasswordController.text.isEmpty){
      alertText = "One of the fields is empty, please check";
      showAlertDialog(context); 
    }else{
      User result = provider.UserList.holder.firstWhere((x) => x.emailAddress == emailController.text, orElse: () => User("","","",""));
      if(result.emailAddress.isNotEmpty){
        alertText = "Email already taken, please enter a new one.";
        showAlertDialog(context); 
      }else{
        if(passwordController.text != confirmPasswordController.text){
          alertText = "Passwords don't match, please re-check and try again.";
          showAlertDialog(context); 
        }else{
          provider.UserList.addUser(firstNameController.text, lastNameController.text, emailController.text, passwordController.text);
          alertText = "Signup successfull! Please go to login page and login.";
          resetFields();
          showAlertDialog(context); 
        }
      }
    }
  }

  resetFields() async {
    lastNameController.text = emailController.text = passwordController.text = confirmPasswordController.text = firstNameController.text = "";
  }

  loginNavigation() async {
      Navigator.pushNamed(context, LoginScreen.routeName);
  }
}