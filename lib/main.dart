import 'package:elapor_polije/pages/auth/login.dart';
import 'package:elapor_polije/pages/auth/recovery.dart';
import 'package:elapor_polije/pages/auth/register.dart';
import 'package:elapor_polije/pages/landing.dart';
import 'package:elapor_polije/pages/menus/about.dart';
import 'package:elapor_polije/pages/menus/aspirasi.dart';
import 'package:elapor_polije/pages/menus/informasi.dart';
import 'package:elapor_polije/pages/menus/laporan.dart';
import 'package:elapor_polije/pages/menus/pengaduan.dart';
import 'package:elapor_polije/pages/menus/setting.dart';
import 'package:elapor_polije/pages/menus/settings/change_email.dart';
import 'package:elapor_polije/pages/menus/settings/change_password.dart';
import 'package:flutter/material.dart';
import 'package:elapor_polije/component/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(dotenv.env['API_URL']);
    return MaterialApp(
      title: 'Polije Complaint Information System',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        Landing.nameRoute: (context) => const Landing(),
        Login.nameRoute: (context) => const Login(),
        Register.nameRoute: (context) => const Register(),
        Recovery.nameRoute: (context) => const Recovery(),
        Laporan.nameRoute: (context) => const Laporan(),
        Pengaduan.nameRoute: (context) => const Pengaduan(),
        Aspirasi.nameRoute: (context) => const Aspirasi(),
        Informasi.nameRoute: (context) => const Informasi(),
        Setting.nameRoute: (context) => const Setting(),
        ChangeEmail.nameRoute: (context) => const ChangeEmail(),
        ChangePassword.nameRoute: (context) => const ChangePassword(),
        About.nameRoute: (context) => const About(),
      },
    );
  }
}
