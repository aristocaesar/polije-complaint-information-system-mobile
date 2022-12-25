import 'dart:convert';
import 'package:elapor_polije/session/session.dart';
import 'package:elapor_polije/session/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:elapor_polije/pages/auth/recovery.dart';
import 'package:elapor_polije/pages/auth/register.dart';
import 'package:elapor_polije/pages/landing.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const nameRoute = "/login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // global state
  final userState = Get.put(UserStateController());
  // form state
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  // controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Session().get("id").then((value) {
      if (value != "null") {
        Session().restoreSession();
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed(Landing.nameRoute);
      }
    });
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
                    "Masuk",
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
                                  maxLength: 64,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    hintText: "Ketikkan Email",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
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
                                  maxLength: 64,
                                  keyboardType: TextInputType.name,
                                  controller: _passwordController,
                                  obscureText: !_passwordVisible,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    hintText: "Ketikkan Password",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: const Color.fromRGBO(
                                            15, 76, 117, 1),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(Recovery.nameRoute);
                                  },
                                  style: ButtonStyle(
                                    alignment: Alignment.centerLeft,
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                      EdgeInsets.zero,
                                    ),
                                  ),
                                  child: const Text(
                                    'Lupa Password ?',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 106, 106, 106),
                                        fontFamily: "Poppins"),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
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
                                    onPressed: () {
                                      _loginSubmit(
                                              _emailController.text,
                                              _passwordController.text,
                                              userState)
                                          .then((value) {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                Landing.nameRoute);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Hallo, ${userState.namaLengkap.toString()}"),
                                        ));
                                      }).catchError((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(value),
                                        ));
                                      });
                                    },
                                    child: const Text(
                                      "Masuk",
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

Future<bool> _loginSubmit(
    String email, String password, UserStateController userState) async {
  // cek fieled empty
  if (email.isEmpty || password.isEmpty) {
    throw "Harap melengkapi email dan password";
  }
  if (!email.isEmail) {
    throw "Email yang anda masukkan tidak valid";
  }
  // cek length field
  if (email.length < 6 || password.length < 5) {
    throw "Email atau password yang anda masukkan terlalu pendek";
  }
  var data = <String, dynamic>{};
  data["email"] = email.trim();
  data["password"] = password.trim();
  var response =
      await http.post(Uri.parse("${dotenv.env['API_HOST']}/login"), body: data);
  var result = json.decode(response.body);
  if (result["status"] != "ERR") {
    var user = result["data"];
    // init sessions
    userState.setState(
        user["id"],
        user["nama"],
        user["email"],
        "${dotenv.env['BASE_HOST']}/public/upload/assets/images/${user['foto']}",
        user["verifikasi_email"]);
    Session().setSession({
      "id": user["id"],
      "nama": user["nama"],
      "email": user["email"],
      "foto":
          "${dotenv.env['BASE_HOST']}/public/upload/assets/images/${user['foto']}",
      "verifikasi_email": user["verifikasi_email"]
    });
    return true;
  } else {
    throw result["data"]["message"];
  }
}
