import 'package:elapor_polije/pages/auth/login.dart';
import 'package:elapor_polije/pages/menus/laporan.dart';
import 'package:elapor_polije/pages/menus/setting.dart';
import 'package:elapor_polije/session/session.dart';
import 'package:elapor_polije/session/user_state.dart';
import 'package:flutter/material.dart';
import 'package:elapor_polije/pages/landing.dart';
import 'package:elapor_polije/pages/menus/about.dart';
import 'package:get/get.dart';

class DrawerComponent extends StatefulWidget {
  const DrawerComponent({Key? key}) : super(key: key);

  @override
  State<DrawerComponent> createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GetBuilder<UserStateController>(
        init: UserStateController(),
        builder: (controller) => ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(15, 76, 117, 1),
              ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: controller.foto != ""
                      ? Image.network(
                          controller.foto,
                          fit: BoxFit.cover,
                        )
                      : Image.asset("assets/images/USER-default.png"),
                ),
              ),
              accountName: Text(
                controller.namaLengkap,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "Poppins"),
              ),
              accountEmail: Text(
                controller.email,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 203, 203, 203),
                    fontFamily: "Poppins"),
              ),
            ),
            ListTile(
              title: const Text(
                'Layanan',
                style: TextStyle(fontFamily: "Poppins"),
              ),
              leading: const Icon(Icons.layers),
              onTap: () async {
                Navigator.pop(context);
                Navigator.of(context).pushReplacementNamed(Landing.nameRoute);
              },
            ),
            ListTile(
              title: const Text(
                'Laporan',
                style: TextStyle(fontFamily: "Poppins"),
              ),
              leading: const Icon(Icons.archive),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacementNamed(Laporan.nameRoute);
              },
            ),
            ListTile(
              title: const Text('Pengaturan',
                  style: TextStyle(fontFamily: "Poppins")),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Setting()),
                );
              },
            ),
            ListTile(
              title: const Text('Tentang',
                  style: TextStyle(fontFamily: "Poppins")),
              leading: const Icon(Icons.info),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(About.nameRoute);
              },
            ),
            ListTile(
              title:
                  const Text('Keluar', style: TextStyle(fontFamily: "Poppins")),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(Login.nameRoute);
                Session().destroySession();
              },
            ),
          ],
        ),
      ),
    );
  }
}
