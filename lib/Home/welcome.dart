import 'package:carrentalapp/Home/login.dart';
import 'package:carrentalapp/Home/register.dart';
import 'package:carrentalapp/widgets/customcontainer.dart';
import 'package:carrentalapp/widgets/customtext.dart';
import 'package:flutter/material.dart';

class Welcomescreen extends StatefulWidget {
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: 800,
              width: 400,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://i.pinimg.com/originals/ff/0b/30/ff0b303b2d164ed4fd9a552237f9862b.jpg"),
                      fit: BoxFit.fill)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 25, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const customtext(
                      title: "Car2go",
                      color: Colors.orange,
                      size: 25,
                      fontWeight: FontWeight.bold),
                  const SizedBox(
                    height: 60,
                  ),
                  const customtext(
                    title: "Welcome,",
                    color: Colors.white,
                    size: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  const customtext(
                    title: "Find the ideal car",
                    color: Colors.white,
                    size: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  const customtext(
                    title: "rental for your trip!",
                    color: Colors.white,
                    size: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 510,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Loginscreen(),
                            )),
                        child: const customcontainer(
                            textwidget: customtext(
                              title: "Login",
                              color: Colors.white,
                              size: 20,
                              fontWeight: FontWeight.normal,
                            ),
                            color: Colors.black,
                            height: 40,
                            width: 145,
                            curve: 30),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Registerscreen(),
                            )),
                        child: const customcontainer(
                            textwidget: customtext(
                              title: "Register",
                              color: Colors.black,
                              size: 20,
                              fontWeight: FontWeight.normal,
                            ),
                            color: Colors.white,
                            height: 40,
                            width: 145,
                            curve: 30),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
