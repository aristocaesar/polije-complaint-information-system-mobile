import 'dart:async';

import 'package:elapor_polije/session/user_state.dart';
import 'package:flutter/material.dart';
import 'package:elapor_polije/component/hero_main.dart';
import 'package:elapor_polije/component/drawer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  static const nameRoute = "/change_password";
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  // global state
  final userState = Get.put(UserStateController());

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
                HeroComponent(title: "Password", drawer: _scaffoldKey),
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
                                "Password Baru",
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
                                  hintText: "Ketik Password Baru",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                              const SizedBox(height: 30),
                              const Text(
                                "Konfirmasi Password Baru",
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
                                  hintText: "Ketik Ulang Password Baru",
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
                                  hintText: "Ketikkan Password Lama",
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
                              const Text(
                                  "Setelah anda mengklik simpan, anda akan otomatis logout.",
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 16)),
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
                                  onPressed: () {
                                    _submitChangePassword(
                                            _passwordController.text,
                                            _konfirmasiPasswordController.text,
                                            _oldPasswordController.text,
                                            userState)
                                        .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            'Password berhasil diperbarui, anda'),
                                      ));
                                      Navigator.pop(context);
                                    }).catchError((error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(error),
                                      ));
                                    });
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
                              const SizedBox(
                                height: 80,
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

Future<bool> _submitChangePassword(String password, String konfirmasiPassword,
    String passwordLama, UserStateController userState) async {
  // check password match
  if (password != konfirmasiPassword) {
    throw "Password tidak sama";
  }
  // change password
  var data = <String, dynamic>{};
  data["id_user_mobile"] = userState.id;
  data["password"] = password.trim();
  data["password2"] = konfirmasiPassword.trim();
  data["old_password"] = passwordLama.trim();
  var response = await http.post(
      Uri.parse("${dotenv.env['API_HOST']}/pengguna/changepassword"),
      body: data);
  var result = json.decode(response.body);
  if (result["status"] == "ERR") {
    throw result["data"]["message"];
  }
  return true;
}
