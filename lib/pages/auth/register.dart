import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elapor_polije/pages/auth/login.dart';
import "package:http/http.dart" as http;

class Register extends StatefulWidget {
  static const nameRoute = "/register";
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // form state
  final _formKey = GlobalKey<FormState>();

  // controller
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final TextEditingController _kontakController = TextEditingController();
  final TextEditingController dateinput = TextEditingController();
  // jenis kelamin
  final List<String> genderItems = [
    'Laki-Laki',
    'Perempuan',
  ];
  String? genderSelected;
  // status
  final List<String> statusItems = [
    'Mahasiswa / Mahasiswi',
    'Dosen',
    'Staf',
    'Masyarakat',
  ];
  String? statusSelected;

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

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
                    "Daftar",
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
                                  "Nama Lengkap",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.name,
                                  maxLength: 64,
                                  controller: _namaController,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    hintText: "Ketikkan Nama Lengkap",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Tanggal Lahir",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: dateinput,
                                  decoration: InputDecoration(
                                    hintText: "Masukkan Tanggal Lahir",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101));

                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      setState(() {
                                        dateinput.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Jenis Kelamin",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                DropdownButtonFormField2(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  isExpanded: true,
                                  hint: const Text(
                                    'Pilih Jenis Kelamin',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black45,
                                  ),
                                  iconSize: 30,
                                  buttonHeight: 60,
                                  buttonPadding: const EdgeInsets.only(
                                      left: 20, right: 10),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  items: genderItems
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    genderSelected = value.toString();
                                  },
                                  onSaved: (value) {
                                    genderSelected = value.toString();
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
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
                                  keyboardType: TextInputType.name,
                                  maxLength: 64,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    hintText: "Ketikkan Password",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
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
                                  keyboardType: TextInputType.name,
                                  maxLength: 64,
                                  controller: _password2Controller,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    hintText: "Ketikkan Password",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "No Telp",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: _kontakController,
                                  decoration: InputDecoration(
                                    hintText: "Ketikkan No Telp",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Status",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                DropdownButtonFormField2(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  isExpanded: true,
                                  hint: const Text(
                                    'Pilih Status',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black45,
                                  ),
                                  iconSize: 30,
                                  buttonHeight: 60,
                                  buttonPadding: const EdgeInsets.only(
                                      left: 20, right: 10),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  items: statusItems
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    statusSelected = value.toString();
                                  },
                                  onSaved: (value) {
                                    statusSelected = value.toString();
                                  },
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
                                        if (await _registerSubmit(
                                            _namaController.text,
                                            dateinput.text,
                                            genderSelected.toString(),
                                            _emailController.text,
                                            _passwordController.text,
                                            _password2Controller.text,
                                            _kontakController.text,
                                            statusSelected.toString())) {
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Berhasil Registrasi, Silakan Verifikasi dan Login'),
                                          ));
                                          Timer(
                                              const Duration(seconds: 2),
                                              () => Navigator.of(context)
                                                  .pushNamed(Login.nameRoute));
                                        }
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(e.toString()),
                                        ));
                                      }
                                    },
                                    child: const Text(
                                      "Daftar",
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
                                        .pushNamed(Login.nameRoute);
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
                                        'Sudah punya akun ?',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 106, 106, 106),
                                            fontFamily: "Poppins"),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Masuk',
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

Future<bool> _registerSubmit(
    String namaLengkap,
    String tanggalLahir,
    String jenisKelamin,
    String email,
    String password,
    String password2,
    String kontak,
    String status) async {
  if (namaLengkap.isNotEmpty &&
      tanggalLahir.isNotEmpty &&
      jenisKelamin != "null" &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      password2.isNotEmpty &&
      kontak.isNotEmpty &&
      status != "null") {
    // nama lengkap
    if (namaLengkap.length < 4) {
      throw "Nama yang anda masukkan terlalu pendek";
    }
    // check email
    if (email.length < 6) {
      throw "Email yang anda masukkan terlalu pendek";
    }
    if (email.isEmail) {
      throw "Email yang anda masukkan tidak valid";
    }
    // check password
    if (password != password2) {
      throw "Password tidak sama";
    }
    if (password.length < 5 || password2.length < 5) {
      throw "Password yang anda masukkan terlalu pendek";
    }
    // kontak
    if (kontak.length < 4 || !kontak.isNumericOnly) {
      throw "Kontak yang anda masukkan tidak valid";
    }
    // register
    var data = <String, dynamic>{};
    data["nama_lengkap"] = namaLengkap.trim();
    data["email"] = email.trim();
    data["password"] = password.trim();
    data["tgl_lahir"] = tanggalLahir.trim();
    data["jenis_kelamin"] = jenisKelamin.trim();
    data["password"] = password.trim();
    data["password2"] = password2.trim();
    data["kontak"] = kontak.trim();
    var sts = status.toLowerCase().replaceAll(RegExp(" +"), "");
    data["status"] = sts.replaceAll("/", "_").trim();
    var response = await http
        .post(Uri.parse("${dotenv.env['API_HOST']}/register"), body: data);
    var result = json.decode(response.body);
    if (result["status"] != "ERR") {
      return true;
    } else {
      throw result["data"]["message"];
    }
  } else {
    throw "Harap melengkapi data";
  }
}
