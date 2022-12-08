import 'package:flutter_intro_jamian_jade/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserList{
   static List<User> holder = <User>[];

   static void addUser(String fn, String ln, String ea, String pw){
    holder.add(User(fn, ln, ea, pw));
   }
}

class LocalStorage{
  static SharedPreferences? localStorage;
  static init() async {
    localStorage = await SharedPreferences.getInstance();
  }

  static setToLocalStorage(String email, String UID) {
      localStorage!.setString('emailVal', email);
      localStorage!.setString('UIDVal', UID);
  }

  static removeFromLocalStorage() {
      localStorage!.remove('emailVal');
      localStorage!.remove('UIDVal');
  }
}