import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:elapor_polije/pages/landing.dart';
import 'package:elapor_polije/pages/menus/about.dart';

class DrawerComponent extends StatefulWidget {
  const DrawerComponent({Key? key}) : super(key: key);

  @override
  State<DrawerComponent> createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(15, 76, 117, 1),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/USER-default.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            accountName: const Text(
              'Ferdy Sambo',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: "Poppins"),
            ),
            accountEmail: const Text(
              'ferdysambo@kapolri.gov.id',
              style: TextStyle(
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Landing()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Laporan',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            leading: const Icon(Icons.archive),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Pengaturan',
                style: TextStyle(fontFamily: "Poppins")),
            leading: const Icon(Icons.settings),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title:
                const Text('Tentang', style: TextStyle(fontFamily: "Poppins")),
            leading: const Icon(Icons.info),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const About()),
              );
            },
          ),
          ListTile(
            title:
                const Text('Keluar', style: TextStyle(fontFamily: "Poppins")),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}
