import 'package:flutter/material.dart';
import 'package:polije_complaint_information_system_mobile/component/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Polije Complaint Information System',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
