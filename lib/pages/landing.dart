import 'package:elapor_polije/session/user_state.dart';
import 'package:flutter/material.dart';
import 'package:elapor_polije/component/hero_main.dart';
import 'package:elapor_polije/component/drawer.dart';
import 'package:elapor_polije/pages/menus/aspirasi.dart';
import 'package:elapor_polije/pages/menus/informasi.dart';
import 'package:elapor_polije/pages/menus/pengaduan.dart';
import 'package:get/get.dart';

class Landing extends StatefulWidget {
  static const nameRoute = "/landing";
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  // global state
  final userState = Get.put(UserStateController());

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
                HeroComponent(title: "Layanan", drawer: _scaffoldKey),
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
                            children: [
                              _buildItemKlasifikasi(
                                  context,
                                  Icons.chat_bubble_outline,
                                  "Pengaduan",
                                  "Laporkan sebuah informasi",
                                  Pengaduan.nameRoute,
                                  userState),
                              _buildItemKlasifikasi(
                                  context,
                                  Icons.send,
                                  "Aspirasi",
                                  "Kirimkan suara aspirasimu",
                                  Aspirasi.nameRoute,
                                  userState),
                              _buildItemKlasifikasi(
                                  context,
                                  Icons.info,
                                  "Informasi",
                                  "Dapatkan informasi kampus",
                                  Informasi.nameRoute,
                                  userState)
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            )));
  }
}

Widget _buildItemKlasifikasi(BuildContext ctx, IconData icon, String title,
    String description, String push, UserStateController userState) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          if (userState.verifikasiEmail == "belum_terverifikasi") {
            ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
              content:
                  Text("Harap verifikasi email sebelum menggunakan layanan"),
            ));
          } else {
            Navigator.pop(ctx);
            Navigator.of(ctx).pushNamed(push);
          }
        },
        child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: ListTile(
                  leading: Icon(icon,
                      size: 40, color: const Color.fromRGBO(15, 76, 117, 1)),
                  title: Text(
                    title,
                    style: const TextStyle(
                        color: Color.fromRGBO(15, 76, 117, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        fontFamily: "Poppins"),
                  ),
                  subtitle: Text(description,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 217, 217, 217),
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          fontFamily: "Poppins"))),
            )),
      ),
      const SizedBox(height: 25)
    ],
  );
}
