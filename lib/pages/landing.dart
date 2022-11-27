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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text("POLIJE",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                  fontFamily: "Poppins")),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background-app.png"),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 150),
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
                const SizedBox(height: 100),
                Container(
                  height: MediaQuery.of(context).size.height - 303,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          topRight: Radius.circular(50.0))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 50.0, right: 30.0, left: 30.0),
                    child: Column(
                      children: <Widget>[
                        _buildItemKlasifikasi(Icons.menu, "Lapor",
                            "Laporkan sebuah informasi", "/laporan"),
                        _buildItemKlasifikasi(Icons.menu, "Lapor",
                            "Laporkan sebuah informasi", "/laporan"),
                        _buildItemKlasifikasi(Icons.menu, "Lapor",
                            "Laporkan sebuah informasi", "/laporan")
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}

Widget _buildItemKlasifikasi(
    IconData icon, String title, String description, String push) {
  return Column(
    children: [
      Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5), //color of shadow
                spreadRadius: 0, //spread radius
                blurRadius: 5, // blur radius
                offset: const Offset(0, 4))
          ],
        ),
        child: Center(child: Text(title)),
      ),
      const SizedBox(height: 25)
    ],
  );
}
