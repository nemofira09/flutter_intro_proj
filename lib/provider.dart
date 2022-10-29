import 'package:flutter_intro_jamian_jade/models/User.dart';

class UserList{
   static List<User> holder = <User>[];

   static void addUser(String fn, String ln, String ea, String pw){
    holder.add(User(fn, ln, ea, pw));
   }
}