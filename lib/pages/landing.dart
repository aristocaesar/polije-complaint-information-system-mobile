import 'package:flutter/material.dart';
import 'package:polije_complaint_information_system_mobile/component/drawer.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("POLIJE",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1,
                fontFamily: "Poppins")),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(15, 76, 117, 100),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer())),
        ],
      ),
      drawer: const DrawerComponent(),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("/images/background-app.png"),
                fit: BoxFit.fill)),
        child: ListView(
          children: const <Widget>[
            SizedBox(height: 80),
            Center(
              child: Text(
                "Layanan",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
