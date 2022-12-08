import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static GoogleSignIn googleSignIn = GoogleSignIn();

  GoogleSignInAccount? User;

  Future signIn(String emailAddress, String password) async {
  try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password
    );
    print(credential);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

Future signUp(String emailAddress, String password) async {
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
  }

  Future logout () async {
    try {
      //await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
    } catch (e) { 
      return null;
    }
  }
}