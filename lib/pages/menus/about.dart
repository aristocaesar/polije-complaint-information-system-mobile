import 'package:flutter/material.dart';
import 'package:elapor_polije/component/drawer.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: const DrawerComponent(),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background-app.png"),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "POLIJE",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            icon: const Icon(Icons.menu,
                                size: 35, color: Colors.white),
                            onPressed: () =>
                                {_scaffoldKey.currentState?.openDrawer()})
                      ]),
                ),
                const SizedBox(height: 50),
                const Center(
                  child: Text(
                    "Tentang",
                    style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 100),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            topRight: Radius.circular(50.0))),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, right: 20.0, left: 20.0),
                          child: ListView(
                            children: const [
                              Text(
                                "Pengelolaan pengaduan pelayanan publik di Politeknik Negeri Jember belum terkelola secara efektif dan terintegrasi. Masing-masing penyelenggara mengelola pengaduan secara parsial dan tidak terkoordinir dengan baik. Akibatnya terjadi duplikasi penanganan pengaduan, atau bahkan bisa terjadi suatu pengaduan tidak ditangani oleh satupun penyelenggara, dengan alasan pengaduan bukan kewenangannya. Oleh karena itu, untuk mencapai visi dalam good governance maka perlu untuk mengintegrasikan sistem pengelolaan pengaduan pelayanan publik dalam satu pintu. Tujuannya, Politeknik Negeri Jember memiliki satu saluran pengaduan yang baik dan tertata.",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                "Untuk itu Politeknik Negeri Jember membentuk Sistem Pengelolaan Pengaduan Pelayanan Kampus - Layanan Aspirasi dan Pengaduan Online adalah layanan penyampaian semua aspirasi dan pengaduan masyrakat Politeknik Negeri Jember melalui beberapa kanal pengaduan yaitu website www.lapor.polije.ac.id serta aplikasi mobile (Android).",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            )));
  }
}
