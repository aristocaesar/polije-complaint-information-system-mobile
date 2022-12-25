import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:elapor_polije/pages/auth/login.dart';
import 'package:elapor_polije/pages/auth/register.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

class Recovery extends StatefulWidget {
  static const nameRoute = "/recovery";
  const Recovery({Key? key}) : super(key: key);

  @override
  State<Recovery> createState() => _RecoveryState();
}

class _RecoveryState extends State<Recovery> {
  // form state
  final _formKey = GlobalKey<FormState>();

  // controller
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background-app.png"),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 100),
                const Center(
                  child: Text(
                    "Lupa Password",
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
                    child: Form(
                      key: _formKey,
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, right: 20.0, left: 20.0),
                            child: ListView(
                              children: [
                                const Text(
                                  "Email",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    hintText: "Ketikkan Email",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
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
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text("Mohon tunggu sebentar"),
                                        ));
                                        if (await _recoverySubmit(
                                            _emailController.text)) {
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Tautan berhasil dikirimkan, silakan cek email!"),
                                          ));
                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context)
                                              .pushNamed(Login.nameRoute);
                                        }
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(e.toString()),
                                        ));
                                      }
                                    },
                                    child: const Text(
                                      "Kirim",
                                      style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontSize: 18,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(Register.nameRoute);
                                  },
                                  style: ButtonStyle(
                                    alignment: Alignment.centerLeft,
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                      EdgeInsets.zero,
                                    ),
                                  ),
                                  child: Row(
                                    children: const [
                                      Text(
                                        'Belum punya akun ?',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 106, 106, 106),
                                            fontFamily: "Poppins"),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Daftar',
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(15, 76, 117, 1),
                                            fontFamily: "Poppins"),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}

Future<bool> _recoverySubmit(String email) async {
  // check length email
  if (email.isEmpty) {
    throw "Harap melengkapi data email";
  }
  if (email.length < 6) {
    throw "Email yang anda masukkan terlalu pendek";
  }
  // validate email
  if (email.isEmail) {
    throw "Email yang anda masukkan tidak valid";
  }
  var data = <String, dynamic>{};
  data["email"] = email.trim();
  var response = await http
      .post(Uri.parse("${dotenv.env['API_HOST']}/recovery"), body: data);
  var result = json.decode(response.body);
  if (result["status"] != "ERR") {
    return true;
  } else {
    throw result["data"]["message"];
  }
}
