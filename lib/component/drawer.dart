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
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(15, 76, 117, 1),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://image.shutterstock.com/shutterstock/photos/1436193641/display_1500/stock-vector-japanese-samurai-soldier-on-illustration-1436193641.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            accountName: const Text(
              'Ferdy Sambo',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: "Poppins"),
            ),
            accountEmail: const Text(
              'ferdysambo@kapolri.gov.id',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
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
