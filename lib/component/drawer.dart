import 'package:flutter/material.dart';

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
          const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(15, 76, 117, 100),
              ),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(15, 76, 117, 100),
                ),
                currentAccountPicture: ClipOval(
                  child: FlutterLogo(
                    size: 300,
                    textColor: Colors.blue,
                    style: FlutterLogoStyle.stacked,
                  ),
                ),
                accountName: Text(
                  'Ferdy Sambo',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: "Poppins"),
                ),
                accountEmail: Text(
                  'ferdysambo@kapolri.gov.id',
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      color: Colors.white,
                      fontFamily: "Poppins"),
                ),
              )),
          ListTile(
            title: const Text(
              'Layanan',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            leading: const Icon(Icons.layers),
            onTap: () {
              // Update the state of the app.
              // ...
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
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title:
                const Text('Keluar', style: TextStyle(fontFamily: "Poppins")),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
