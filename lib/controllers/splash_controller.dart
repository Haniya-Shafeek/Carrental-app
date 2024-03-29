import 'package:carrentalapp/utilities/constants.dart';
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
  late User? _curretuser;

  // late User? _curretuser;
  void checklogin(context) async {
    _curretuser = FirebaseAuth.instance.currentUser;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userlogin = sharedPreferences.getBool("login");
    adminlogin = sharedPreferences.getBool("adlogin");
    // _curretuser = FirebaseAuth.instance.currentUse
    // _curretuser = FirebaseAuth.instance.currentUser;
    if (userlogin == false || userlogin == null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Welcomescreen(),
          ));
    
    }
    else{
      Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Mainscreen(),
            ));
    }
  }
}
