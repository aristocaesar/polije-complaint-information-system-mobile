import 'dart:async';

import 'package:flutter/material.dart';
import 'package:polije_complaint_information_system_mobile/pages/auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashScreenStart();
  }

  splashScreenStart() async {
    return Timer(const Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/images/background-politeknik-negeri-jember.png"),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/logo-politeknik-negeri-jember.png",
                width: 100,
              ),
              const Text(
                "Layanan Aspirasi dan Pengaduan Online",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1,
                    fontFamily: "Poppins"),
              ),
              const Text(
                "Politeknik Negeri Jember",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w100,
                    color: Colors.white,
                    fontFamily: "Poppins"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
