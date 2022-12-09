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
  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }

  static Future setToLocalStorage(String email, String uid) async{
      await localStorage!.setString('emailVal', email);
      await localStorage!.setString('UIDVal', uid);
  }
}