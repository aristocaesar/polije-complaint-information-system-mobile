import 'package:flutter/material.dart';
import 'package:elapor_polije/component/hero_main.dart';
import 'package:elapor_polije/component/drawer.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // controller
  final _passwordController = TextEditingController();
  final _konfirmasiPasswordController = TextEditingController();
  final _oldPasswordController = TextEditingController();

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
                HeroComponent(title: "Ganti Password", drawer: _scaffoldKey),
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
                              const Text(
                                "Password",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  hintText: "Ketik Password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                              const SizedBox(height: 30),
                              const Text(
                                "Konfirmasi Password",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _konfirmasiPasswordController,
                                decoration: InputDecoration(
                                  hintText: "Ketik Ulang Password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Password Lama",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _oldPasswordController,
                                decoration: InputDecoration(
                                  hintText: "Ketikkan Email",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                              const SizedBox(height: 30),
                              const Text(
                                'Perhatikan',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      const SizedBox(width: 5),
                                      const Text(
                                        'Setelah anda mengklik konfirmasi, anda ',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      const SizedBox(width: 5),
                                      const Text(
                                        'akan otomatis keluar.',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                width: 200,
                                height: 60,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(15, 76, 117, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () async {
                                    try {
                                      if (await _SubmitPassword(
                                        _passwordController.text,
                                        _konfirmasiPasswordController.text,
                                        _oldPasswordController.text,
                                      )) {}
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('email telah terganti'),
                                      ));
                                    }
                                  },
                                  child: const Text(
                                    "Simpan",
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 18,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold),
                                  ),
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

Future<bool> _SubmitPassword(
    String email, String password, String konfirmasipassword) async {
  // Obtain shared preferences.
  // final prefs = await SharedPreferences.getInstance();
  // print(email);
  // print(password);
  // print(konfirmasiPassword)
  return true;
}
