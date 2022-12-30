import 'dart:convert';
import 'package:elapor_polije/component/string_extentions.dart';
import 'package:flutter/material.dart';
import 'package:elapor_polije/component/hero_main.dart';
import 'package:elapor_polije/component/drawer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class DetailLaporan extends StatefulWidget {
  final String id;
  const DetailLaporan({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailLaporan> createState() => _DetailLaporanState();
}

class _DetailLaporanState extends State<DetailLaporan> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //form state
  final TextEditingController deskripsiPengaduan = TextEditingController();
  final TextEditingController kategori = TextEditingController();
  final TextEditingController divisi = TextEditingController();
  final TextEditingController status = TextEditingController();
  final TextEditingController dateinput = TextEditingController();
  final TextEditingController deskripsiTanggapan = TextEditingController();
  String lampiranPengguna = "";
  String lampiranPetugas = "";

  Future _getLaporan(String id) async {
    var jenisLaporan = id.replaceAll(RegExp(r'[^A-Z,.]+'), "");
    var jenisLaporanSelect = jenisLaporan == "ADU"
        ? "pengaduan"
        : jenisLaporan == "INFO"
            ? "informasi"
            : jenisLaporan == "ASPI"
                ? "aspirasi"
                : "";
    var dataKlasifikasi = await http
        .get(Uri.parse("${dotenv.env['API_HOST']}/$jenisLaporanSelect/$id"));
    var response = json.decode(dataKlasifikasi.body);
    deskripsiPengaduan.text = response["data"]["deskripsi"];
    kategori.text = response["data"]["kategori"];
    divisi.text = response["data"]["divisi"];
    status.text = StringExtentions.ucwords(
        response["data"]["status"].toString().replaceAll("_", " "));
    dateinput.text = response["data"]["created_at"];
    deskripsiTanggapan.text =
        response["data"]["tanggapan"] ?? "Belum ada tanggapan";
    if (response['data']['lampiran_pengirim'] != null) {
      setState(() {
        lampiranPengguna =
            "${dotenv.env['BASE_HOST']}/public/upload/assets/document/$jenisLaporanSelect/${response['data']['lampiran_pengirim']}";
      });
    }
    if (response['data']['lampiran'] != null) {
      setState(() {
        lampiranPetugas =
            "${dotenv.env['BASE_HOST']}/public/upload/assets/document/$jenisLaporanSelect/${response['data']['lampiran']}";
      });
    }
  }

  @override
  void initState() {
    _getLaporan(widget.id);
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
                HeroComponent(title: widget.id, drawer: _scaffoldKey),
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
                                'Detail Pengaduan',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 17),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Deskripsi",
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 17),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: deskripsiPengaduan,
                                maxLines: 8,
                                readOnly: true,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(15),
                                  hintText: "Masukkan Deskripsi",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Kategori",
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 17),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: kategori,
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText: "Kategori",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Divisi Tujuan",
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 17),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: divisi,
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText: "Ketikkan Tujuan Divisi",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Lampiran",
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 17),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                // statesController: lampiranPengaduan,
                                style: const ButtonStyle(
                                    alignment: Alignment.centerLeft,
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.zero)),

                                onPressed: () {
                                  if (lampiranPengguna != "") {
                                    Lampiran.checkMimeType(lampiranPengguna)
                                        .then((mimeType) {
                                      if (mimeType == "image") {
                                        showDialog(
                                            context: context,
                                            builder: (_) =>
                                                ImageDialog(lampiranPengguna));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Lampiran hanya data tersedia pada website"),
                                        ));
                                      }
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Lampiran tidak tersedia"),
                                    ));
                                  }
                                },
                                child: const Text(
                                  'Tampilkan Lampiran',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 67, 151, 219),
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Status",
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 17),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: status,
                                decoration: InputDecoration(
                                  hintText: "Ditangguhkan",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Terakhir Diperbarui",
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 17),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: dateinput,
                                decoration: InputDecoration(
                                  hintText: "16:35:05 04-Desember-2022",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Tanggapan",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 17),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Deskripsi",
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 17),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                readOnly: true,
                                controller: deskripsiTanggapan,
                                maxLines: 8,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(15),
                                  hintText: "Masukkan Deskripsi",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Lampiran",
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 17),
                              ),
                              TextButton(
                                style: const ButtonStyle(
                                    alignment: Alignment.centerLeft,
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.zero)),
                                onPressed: () {
                                  if (lampiranPetugas != "") {
                                    Lampiran.checkMimeType(lampiranPetugas)
                                        .then((mimeType) {
                                      if (mimeType == "image") {
                                        showDialog(
                                            context: context,
                                            builder: (_) =>
                                                ImageDialog(lampiranPetugas));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Lampiran hanya data tersedia pada website"),
                                        ));
                                      }
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Lampiran tidak tersedia"),
                                    ));
                                  }
                                },
                                child: const Text(
                                  'Tampilkan Lampiran',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 67, 151, 219),
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 125),
                                child: SizedBox(
                                  width: 30,
                                  height: 60,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(15, 76, 117, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
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

class Lampiran {
  static Future<String?> checkMimeType(String url) async {
    var response = await http.get(Uri.parse(url));
    return response.headers["content-type"]?.split("/")[0];
  }
}

class ImageDialog extends StatelessWidget {
  final String link;

  const ImageDialog(this.link, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Image.network(link, width: 800, height: 600, fit: BoxFit.cover));
  }
}
