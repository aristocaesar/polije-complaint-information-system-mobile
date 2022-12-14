import 'dart:convert';

import 'package:elapor_polije/pages/menus/setting.dart';
import 'package:elapor_polije/session/session.dart';
import 'package:elapor_polije/session/user_state.dart';
import 'package:flutter/material.dart';
import 'package:elapor_polije/component/hero_main.dart';
import 'package:elapor_polije/component/drawer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChangeEmail extends StatefulWidget {
  static const nameRoute = "/change_email";
  const ChangeEmail({Key? key}) : super(key: key);

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final userState = Get.put(UserStateController());
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // controller
  final _emailController = TextEditingController();
  final _konfirmasiEmailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _passwordVisible = false;

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
                HeroComponent(title: "Ganti Email", drawer: _scaffoldKey),
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
                                "Email Baru",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                maxLength: 64,
                                controller: _emailController,
                                decoration: InputDecoration(
                                  counterText: "",
                                  hintText: "Ketikkan Email Baru",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Konfirmasi Email Baru",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                maxLength: 64,
                                controller: _konfirmasiEmailController,
                                decoration: InputDecoration(
                                  counterText: "",
                                  hintText: "Ketik Ulang Email Baru",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                              const SizedBox(height: 30),
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
                                obscureText: !_passwordVisible,
                                maxLength: 64,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  counterText: "",
                                  hintText: "Ketikkan Password",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color:
                                          const Color.fromRGBO(15, 76, 117, 1),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
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
                              const Text("??? Email Harus Akif.",
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: 16)),
                              const SizedBox(height: 10),
                              const Text(
                                  "??? Jika pesan verifikasi tidak tersedia, harap cek pada bagian spam.",
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
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Mohon tunggu sebentar"),
                                      duration: Duration(seconds: 1),
                                    ));
                                    _submitChangeEmail(
                                            _emailController.text,
                                            _konfirmasiEmailController.text,
                                            _passwordController.text,
                                            userState)
                                        .then((value) {
                                      // update state
                                      userState.verifikasiEmail =
                                          "belum_terverifikasi";
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "Berhasil memperbarui email, silakan verifikasi"),
                                      ));
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              Setting.nameRoute);
                                    }).catchError((error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(error.toString()),
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

Future<bool> _submitChangeEmail(String email, String konfirmasiEmail,
    String password, UserStateController userState) async {
  // check empty filed
  if (email.isEmpty || konfirmasiEmail.isEmpty || password.isEmpty) {
    throw "Harap melengkapi email dan password";
  }
  if (email.length < 6 || konfirmasiEmail.length < 6) {
    throw "Email yang anda masukkan terlalu pendek";
  }
  // check password match
  if (email != konfirmasiEmail) {
    throw "Email yang anda masukkan tidak sama";
  }
  // cek valid email
  if (!email.isEmail || !konfirmasiEmail.isEmail) {
    throw "Email yang anda masukkan tidak valid";
  }
  // cek length password
  if (password.length < 5) {
    throw "Password yang anda masukkan terlalu pendek";
  }
  // change password
  var data = <String, dynamic>{};
  data["id_user_mobile"] = userState.id;
  data["email"] = email.trim();
  data["email2"] = konfirmasiEmail.trim();
  data["password"] = password.trim();
  var response = await http.post(
      Uri.parse("${dotenv.env['API_HOST']}/pengguna/changeemail"),
      body: data);
  var result = json.decode(response.body);
  if (result["status"] == "ERR") {
    throw result["data"]["message"];
  }
  // change state dan session email
  userState.email = email;
  Session().setSession({"email": email});
  return true;
}
