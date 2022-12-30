import 'dart:async';
import 'package:elapor_polije/pages/landing.dart';
import 'package:flutter/material.dart';
import 'package:elapor_polije/pages/auth/login.dart';
import 'package:elapor_polije/session/session.dart';

class SplashScreen extends StatefulWidget {
  static const nameRoute = "/splashscreen";
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
    return Timer(const Duration(seconds: 4), () {
      // jika ada session maka jangan login lagi
      Session().get("id").then((value) {
        if (value != "null") {
          Session().restoreSession();
          Navigator.of(context).pushReplacementNamed(Landing.nameRoute);
        } else {
          Navigator.of(context).pushReplacementNamed(Login.nameRoute);
        }
      });
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Image.asset(
                "assets/images/logo-politeknik-negeri-jember.png",
                width: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                "Layanan Aspirasi dan Pengaduan Online",
                textAlign: TextAlign.center,
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
              ),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}
