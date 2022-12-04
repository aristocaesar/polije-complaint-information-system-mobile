import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elapor_polije/pages/landing.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:elapor_polije/component/drawer.dart';
import 'package:elapor_polije/component/hero_main.dart';
import 'package:elapor_polije/pages/menus/settings/change_email.dart';
import 'package:elapor_polije/pages/menus/settings/change_password.dart';
import 'package:intl/intl.dart';

class Setting extends StatefulWidget {
  static const nameRoute = "/setting";
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  // init scafold -> drawer
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // controller
  final TextEditingController dateinput = TextEditingController();

  // status
  final List<String> statusItems = [
    'Mahasiswa / Mahasiswi',
    'Dosen',
    'Staf',
    'Masyarakat',
  ];
  String? statusSelected;

// jenis kelamin
  final List<String> jenisKelaminItems = [
    'Laki-Laki',
    'Perempuan',
  ];
  String? jenisKelaminSelected;

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

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
                HeroComponent(title: "Pengaturan", drawer: _scaffoldKey),
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
                              // Nama Lengkap
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
                                decoration: InputDecoration(
                                  hintText: "Ketikkan Nama Lengkap",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              // Tanggal Lahir
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
                                      borderRadius: BorderRadius.circular(5.0)),
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
                                        DateFormat('dd-MM-yyyy')
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
                              // Jenis Kelamin
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
                                buttonPadding:
                                    const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                items: jenisKelaminItems
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
                                  jenisKelaminSelected = value.toString();
                                },
                                onSaved: (value) {
                                  jenisKelaminSelected = value.toString();
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              //Alamat
                              const Text(
                                "Alamat",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: "Ketikkan Alamat",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              // Kontak
                              const Text(
                                "Kontak",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Ketikkan Kontak",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              //Status
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
                                buttonPadding:
                                    const EdgeInsets.only(left: 20, right: 10),
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
                              // Email
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
                                decoration: InputDecoration(
                                  hintText: "Ketikkan Email",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(ChangeEmail.nameRoute);
                                },
                                style: ButtonStyle(
                                  alignment: Alignment.centerLeft,
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    EdgeInsets.zero,
                                  ),
                                ),
                                child: const Text(
                                  "Ganti Email",
                                  style: TextStyle(
                                      fontFamily: "Poppins", fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              // Password
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
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(ChangePassword.nameRoute);
                                },
                                style: ButtonStyle(
                                  alignment: Alignment.centerLeft,
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    EdgeInsets.zero,
                                  ),
                                ),
                                child: const Text(
                                  "Ganti Password",
                                  style: TextStyle(
                                      fontFamily: "Poppins", fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              // Foto
                              const Text(
                                "Foto",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(children: [
                                SizedBox(
                                  width: 200,
                                  child: CircleAvatar(
                                    maxRadius: 70,
                                    child: ClipOval(
                                      child: Image.network(
                                        'https://demo.getstisla.com/assets/img/avatar/avatar-1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      selectFile();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      minimumSize: const Size(122, 48),
                                      maximumSize: const Size(122, 48),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                    child: const Text(
                                      "Ganti Foto",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                              const SizedBox(
                                height: 30,
                              ),
                              // Aktifitas Terakhir
                              const Text(
                                "Aktifitas Terakhir",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              // BTN simpan perubahan
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
                                    try {
                                      if (_simpanPerubahan()) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Berhasil memperbarui pengaturan"),
                                        ));
                                        Timer(const Duration(seconds: 2), () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Landing()),
                                          );
                                        });
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(e.toString()),
                                      ));
                                    }
                                  },
                                  child: const Text(
                                    "Simpan Perubahan",
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

//fungsi untuk select file
selectFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    // PlatformFile file = result.files.first;

    // print(file.name);
    // print(file.bytes);
    // print(file.size);
    // print(file.extension);
    // print(file.path);
    return true;
  } else {
    // User canceled the picker
  }
}

_simpanPerubahan() {
  return true;
}
