import 'dart:async';
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elapor_polije/session/user_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:elapor_polije/component/drawer.dart';
import 'package:elapor_polije/component/hero_main.dart';
import 'package:elapor_polije/pages/menus/settings/change_email.dart';
import 'package:elapor_polije/pages/menus/settings/change_password.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Setting extends StatefulWidget {
  static const nameRoute = "/setting";
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  // global state
  final userState = Get.put(UserStateController());

  // init scafold -> drawer
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // input controller
  final TextEditingController namaLengkapControl = TextEditingController();
  final TextEditingController dateinput = TextEditingController();
  final TextEditingController alamatControl = TextEditingController();
  final TextEditingController kontakControl = TextEditingController();
  final TextEditingController emailControl = TextEditingController();
  final TextEditingController recentActivityControl = TextEditingController();

// status verifikasi
  String getUserVerifikasi = "terverifikasi";

  // status
  final List<String> statusItems = [
    'Mahasiswa/Mahasiswi',
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

  Future getUser() async {
    // GET DATA USER WHERE ID
    var id = userState.id;
    var response =
        await http.get(Uri.parse("${dotenv.env['API_HOST']}/pengguna/$id"));
    var result = json.decode(response.body);
    setState(() {
      getUserVerifikasi = result["data"]["verifikasi_email"];
    });
    return result["data"];
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
                          child: FutureBuilder(
                            future: getUser(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                namaLengkapControl.text = snapshot.data["nama"];
                                dateinput.text = snapshot.data["tgl_lahir"];
                                jenisKelaminSelected = snapshot
                                    .data["jenis_kelamin"]
                                    .toString()
                                    .toLowerCase();
                                var jenisKelaminSelectedUser =
                                    (snapshot.data["jenis_kelamin"] ==
                                            "laki-laki"
                                        ? "Laki-Laki"
                                        : "Perempuan");
                                alamatControl.text = snapshot.data["alamat"];
                                kontakControl.text = snapshot.data["kontak"];
                                emailControl.text = snapshot.data["email"] +
                                    " - " +
                                    snapshot.data["verifikasi_email"]
                                        .toString()
                                        .replaceAll("_", " ")
                                        .capitalize;
                                statusSelected = snapshot.data["status"]
                                    .toString()
                                    .toLowerCase()
                                    .replaceAll("_", "/");
                                switch (snapshot.data["status"]) {
                                  case "mahasiswa_mahasiswi":
                                    statusSelected = "Mahasiswa/Mahasiswi";
                                    break;
                                  case "dosen":
                                    statusSelected = "Dosen";
                                    break;
                                  case "staf":
                                    statusSelected = "Staf";
                                    break;
                                  case "masyarakat":
                                    statusSelected = "Masyarakat";
                                    break;
                                  default:
                                }
                                recentActivityControl.text =
                                    snapshot.data["last_login"];

                                return ListView(
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
                                      controller: namaLengkapControl,
                                      decoration: InputDecoration(
                                        hintText: "Ketikkan Nama Lengkap",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2101));

                                        if (pickedDate != null) {
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          dateinput.text = formattedDate;
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
                                      value: jenisKelaminSelectedUser,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
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
                                      items: jenisKelaminItems
                                          .map((item) =>
                                              DropdownMenuItem<String>(
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
                                      controller: alamatControl,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                        hintText: "Ketikkan Alamat",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
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
                                      controller: kontakControl,
                                      decoration: InputDecoration(
                                        hintText: "Ketikkan Kontak",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
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
                                      value: statusSelected,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
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
                                          .map((item) =>
                                              DropdownMenuItem<String>(
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
                                      controller: emailControl,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: "Ketikkan Email",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                ChangeEmail.nameRoute);
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
                                                fontFamily: "Poppins",
                                                fontSize: 18),
                                          ),
                                        ),
                                        _kirimUlangVerifikasi(
                                            context, getUserVerifikasi),
                                      ],
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
                                        Navigator.of(context).pushNamed(
                                            ChangePassword.nameRoute);
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
                                            fontFamily: "Poppins",
                                            fontSize: 18),
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
                                              "${dotenv.env['BASE_HOST']}/public/upload/assets/images/${snapshot.data['foto']}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextButton(
                                          onPressed: () {
                                            selectFile(userState);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
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
                                      controller: recentActivityControl,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
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
                                          backgroundColor: const Color.fromRGBO(
                                              15, 76, 117, 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: () {
                                          try {
                                            _simpanPerubahan(
                                                    userState.id,
                                                    namaLengkapControl.text,
                                                    dateinput.text,
                                                    jenisKelaminSelected
                                                        .toString(),
                                                    alamatControl.text,
                                                    kontakControl.text,
                                                    statusSelected.toString())
                                                .then((value) {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Setting()),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Berhasil memperbarui profil"),
                                              ));
                                            });
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
                                );
                              } else {
                                return ListView(children: const [
                                  Center(
                                    child: Text(
                                      "Sedang Memuat ...",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                          fontSize: 18),
                                    ),
                                  ),
                                ]);
                              }
                            },
                          )),
                    ),
                  ),
                ),
              ],
            )));
  }
}

//fungsi untuk select file
selectFile(UserStateController userState) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom, allowedExtensions: ["jpeg", "png", "jpg"]);
  if (result != null) {
    PlatformFile file = result.files.first;
    var request = http.MultipartRequest(
        "POST", Uri.parse("${dotenv.env['API_HOST']}/pengguna/changefoto"));
    request.fields["id_user_mobile"] = userState.id;
    request.files
        .add(await http.MultipartFile.fromPath("foto", file.path.toString()));
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    if (responsed.statusCode == 200) {
      return true;
    } else {
      throw "Gagal memperbarui foto profil";
    }
  }
}

Widget _kirimUlangVerifikasi(BuildContext ctx, String userVerifikasi) {
  if (userVerifikasi == "belum_terverifikasi") {
    return TextButton(
      onPressed: () async {
        // send ulang token
        // var data = <String, dynamic>{};
        // // data["email"]
        // var response = await http.post(
        //     Uri.parse("${dotenv.env['API_HOST']}/pengguna/update"),
        //     body: data);
        // var result = json.decode(response.body);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          content: Text("Mohon tunggu sebentar"),
        ));
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          content: Text("Tautan verifikasi berhasil dikirim ulang"),
        ));
      },
      style: ButtonStyle(
        alignment: Alignment.centerLeft,
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.zero,
        ),
      ),
      child: const Text(
        "Kirim Ulang Verifikasi",
        style: TextStyle(fontFamily: "Poppins", fontSize: 18),
      ),
    );
  } else {
    return const Text("");
  }
}

Future<bool> _simpanPerubahan(String id, String nama, String tglLahir,
    String jenisKelamin, String alamat, String kontak, String status) async {
  // check empty data
  if (nama.isEmpty || kontak.isEmpty) {
    throw "Harap melengkapi data profile";
  }

  var data = <String, dynamic>{};
  data["id_user_mobile"] = id;
  data["nama"] = nama;
  data["tgl_lahir"] = tglLahir;
  data["jenis_kelamin"] = jenisKelamin;
  data["alamat"] = alamat;
  data["kontak"] = kontak;
  data["status"] = status.replaceAll("/", "_");

  var response = await http
      .post(Uri.parse("${dotenv.env['API_HOST']}/pengguna/update"), body: data);
  var result = json.decode(response.body);
  if (result["status"] == "ERR") {
    throw result["data"]["message"];
  }
  return true;
}
