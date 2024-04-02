import 'package:carrentalapp/view/admin/main_page.dart';
import 'package:carrentalapp/view/user/maun_page.dart';
import 'package:carrentalapp/Home/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashcontrol1er extends ChangeNotifier {
  bool? userlogin;
  bool? adminlogin;
  FirebaseAuth auth = FirebaseAuth.instance;
   void checklogin(context) async {
    SharedPreferences adPreferences = await SharedPreferences.getInstance();
    adminlogin = adPreferences.getBool("adlogin");
    SharedPreferences Preferences = await SharedPreferences.getInstance();
    userlogin = Preferences.getBool("login");
   if (adminlogin == true) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Adminmainscreen(),
          ));
    } else if (userlogin == false || userlogin == null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Welcomescreen(),
          ));
    } else if (userlogin == true) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Mainscreen(),
          ));
    }
  }
}
