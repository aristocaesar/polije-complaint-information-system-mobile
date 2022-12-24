import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elapor_polije/session/user_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:elapor_polije/component/hero_main.dart';
import 'package:elapor_polije/component/drawer.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Klasifikasi extends StatefulWidget {
  final String title;
  const Klasifikasi({Key? key, required this.title}) : super(key: key);

  @override
  State<Klasifikasi> createState() => _KlasifikasiState();
}

class _KlasifikasiState extends State<Klasifikasi> {
  // global state
  final userState = Get.put(UserStateController());
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // controller
  TextEditingController deskripsi = TextEditingController();

  // Text
  bool hasInformasiLaporan = false;
  String btnLaporan = "Kirim Pengaduan";
  String titleDeskripsi = "Deskripsi";
  String hintTextDeskripsi = "Masukkan pengaduan";
  String succesMessage = "Berhasil mengirimkan pengaduan";

  void _setTextDeskripsi() {
    setState(() {
      if (widget.title == "Aspirasi") {
        btnLaporan = "Kirim Aspirasi";
        hintTextDeskripsi = "Masukan sebuah aspirasi";
        succesMessage = "Berhasil mengirimkan aspirasi";
      } else if (widget.title == "Informasi") {
        btnLaporan = "Minta Informasi";
        titleDeskripsi = "Pertanyaan";
        hintTextDeskripsi = "Masukkan sebuah pertanyaan";
        succesMessage = "Berhasil meminta informasi";
      }
    });
  }

  // kategori
  final List<String> kategoriItems = [];
  String kategoriSelected = "";

  // divisi
  final List<String> divisiItems = [];
  String divisiSelected = "";

  // lampiran
  String namaLampiran = "Upload File";
  String pathLampiran = "";

  Future<void> _getDivisiKategori() async {
    // kategori
    List<String> kategori = [];
    var kategoriResponse =
        await http.get(Uri.parse("${dotenv.env['API_HOST']}/kategori"));
    var resultKategori = json.decode(kategoriResponse.body)["data"];
    for (Map i in resultKategori) {
      kategori.add(i["nama"]);
    }

    // divisi
    List<String> divisi = [];
    var divisiResponse =
        await http.get(Uri.parse("${dotenv.env['API_HOST']}/divisi"));
    var resultdivisi = json.decode(divisiResponse.body)["data"];
    for (Map i in resultdivisi) {
      divisi.add(i["nama"]);
    }

    setState(() {
      kategoriItems.addAll(kategori);
      divisiItems.addAll(divisi);
      kategoriSelected = kategoriItems[0];
      divisiSelected = divisiItems[0];
      hasInformasiLaporan = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _getDivisiKategori();
    _setTextDeskripsi();
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
                HeroComponent(title: widget.title, drawer: _scaffoldKey),
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
                          child: !hasInformasiLaporan
                              ? ListView(children: const [
                                  Center(
                                    child: Text(
                                      "Sedang Memuat ...",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                          fontSize: 18),
                                    ),
                                  ),
                                ])
                              : ListView(
                                  children: [
                                    // Katgeori
                                    const Text(
                                      "Kategori",
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
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                      isExpanded: true,
                                      value: kategoriSelected,
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
                                      items: kategoriItems
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
                                        kategoriSelected = value.toString();
                                      },
                                      // onSaved: (value) {
                                      //   kategoriSelected = value.toString();
                                      // },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    const Text(
                                      "Divisi",
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
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                      isExpanded: true,
                                      value: divisiSelected,
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
                                      items: divisiItems
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
                                        divisiSelected = value.toString();
                                      },
                                      onSaved: (value) {
                                        divisiSelected = value.toString();
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    // Deskripsi
                                    Text(
                                      titleDeskripsi,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: deskripsi,
                                      maxLines: 8,
                                      maxLength: 1024,
                                      decoration: InputDecoration(
                                        hintText: hintTextDeskripsi,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    const Text(
                                      "Lampiran",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                border:
                                                    const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5.0),
                                                        ),
                                                        borderSide: BorderSide(
                                                            color: Colors.white,
                                                            width: 2)),
                                                hintText: namaLampiran,
                                                contentPadding:
                                                    const EdgeInsets.all(10.0),
                                              ),
                                              style: const TextStyle(
                                                  fontSize: 16.0)),
                                        ),
                                        const SizedBox(width: 15),
                                        ElevatedButton.icon(
                                          icon: const Icon(
                                            Icons.upload_file,
                                            color: Colors.white,
                                            size: 24.0,
                                          ),
                                          label: const Text('Pilih File',
                                              style: TextStyle(fontSize: 16.0)),
                                          onPressed: () {
                                            selectFile().then((value) {
                                              setState(() {
                                                namaLampiran = value["nama"];
                                                pathLampiran = value["path"];
                                              });
                                            }).catchError((error) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(error.toString()),
                                              ));
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    209, 15, 76, 117),
                                            minimumSize: const Size(122, 48),
                                            maximumSize: const Size(122, 48),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      "*Maksimal ukuran lampiran 10 MB",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
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
                                          _sendLaporan(
                                                  widget.title,
                                                  userState.id,
                                                  kategoriSelected,
                                                  divisiSelected,
                                                  deskripsi.text,
                                                  pathLampiran,
                                                  context)
                                              .then((value) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(succesMessage),
                                            ));
                                          }).catchError((error) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(error.toString()),
                                            ));
                                          });
                                        },
                                        child: Text(
                                          btnLaporan,
                                          style: const TextStyle(
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
Future<Map<String, dynamic>> selectFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    PlatformFile file = result.files.first;
    var lampiran = <String, dynamic>{};
    lampiran["nama"] = file.name;
    lampiran["path"] = file.path;
    return lampiran;
  } else {
    throw "Gagal mencantumkan lampiran";
  }
}

// send informasi
Future<bool> _sendLaporan(String klasifikasi, String id, String kategori,
    String divisi, String deskripsi, String lampiran, BuildContext ctx) async {
  // cek data tidak kosong
  if (kategori.isEmpty || divisi.isEmpty || deskripsi.isEmpty) {
    throw "Harap melengkapi informasi";
  }
  // cek panjang deskripsi
  if (deskripsi.length < 8) {
    throw "Deskripsi ${klasifikasi.toLowerCase()} terlalu pendek";
  } else if (deskripsi.length > 1024) {
    throw "Deskripsi ${klasifikasi.toLowerCase()} terlalu pajang";
  }

  // send laporan
  var laporan = http.MultipartRequest("POST",
      Uri.parse("${dotenv.env['API_HOST']}/${klasifikasi.toLowerCase()}"));
  laporan.fields["id_user_mobile"] = id;
  laporan.fields["deskripsi"] = deskripsi;
  laporan.fields["kategori"] = kategori;
  laporan.fields["divisi"] = divisi;

  if (lampiran.isNotEmpty) {
    laporan.files.add(await http.MultipartFile.fromPath('foto', lampiran));
  }
  laporan.fields["lokasi"] = "Akses tidak diberikan";
  var result = await laporan.send();
  var responseMsg = json.decode(await result.stream.bytesToString());
  if (result.statusCode != 201) {
    throw responseMsg["data"]["message"];
  }
  return true;
}
