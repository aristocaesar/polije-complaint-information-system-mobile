import 'package:flutter/material.dart';
import 'package:polije_complaint_information_system_mobile/component/drawer.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

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
        child: Column(
          children: <Widget>[
            const SizedBox(height: 80),
            const Center(
              child: Text(
                "Layanan",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(15, 76, 117, 100),
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Laporan',
                          style: TextStyle(fontSize: 24, fontFamily: "Poppins"),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
