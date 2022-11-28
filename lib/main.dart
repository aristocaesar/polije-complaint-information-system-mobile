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
    print(dotenv.env['API_URL']);
    return const MaterialApp(
      title: 'Polije Complaint Information System',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
