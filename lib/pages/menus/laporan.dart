import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elapor_polije/pages/menus/laporans/detail_laporan.dart';
import 'package:elapor_polije/session/user_state.dart';
import 'package:flutter/material.dart';
import 'package:elapor_polije/component/hero_main.dart';
import 'package:elapor_polije/component/drawer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:elapor_polije/component/string_extentions.dart';

class Laporan extends StatefulWidget {
  const Laporan({Key? key}) : super(key: key);
  static const nameRoute = "/laporan";

  @override
  State<Laporan> createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final userState = Get.put(UserStateController());
  List _getLaporan = [];
  //Jenis Laporan
  final List<String> jenisLaporan = ['Pengaduan', 'Aspirasi', 'Informasi'];
  String jenisLaporanSelected = "Pengaduan";

  Future _setKlasifikasi() async {
    var dataKlasifikasi = await http.get(Uri.parse(
        "${dotenv.env['API_HOST']}/${jenisLaporanSelected.toString()}/${userState.id}"));
    var response = json.decode(dataKlasifikasi.body);
    setState(() {
      _getLaporan = response["data"];
    });
  }

  @override
  void initState() {
    _setKlasifikasi();
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
                HeroComponent(title: "Laporan", drawer: _scaffoldKey),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            topRight: Radius.circular(50.0))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 35.0, right: 35.0, top: 25.0),
                      child: Column(
                        children: <Widget>[
                          const Text(
                            'Klasifikasi',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonFormField2(
                            value: "Pengaduan",
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'Pilih Klasifikasi',
                              style: TextStyle(fontSize: 14),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 30,
                            buttonHeight: 50,
                            buttonPadding:
                                const EdgeInsets.only(left: 10, right: 10),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            items: jenisLaporan
                                .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(fontSize: 14),
                                    )))
                                .toList(),
                            onChanged: (value) {
                              jenisLaporanSelected = value.toString();
                              _setKlasifikasi();
                            },
                            onSaved: (value) {
                              jenisLaporanSelected = value.toString();
                              _setKlasifikasi();
                            },
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                              child: _getLaporan.isEmpty
                                  ? const Padding(
                                      padding: EdgeInsets.only(top: 25.0),
                                      child: Text(
                                        "Data tidak tersedia",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: _getLaporan.length,
                                      itemBuilder: (context, index) {
                                        var status = _getLaporan[index]
                                                ["status"]
                                            .toString()
                                            .replaceAll("_", " ");
                                        Color warnaStatus =
                                            status == "belum ditanggapi"
                                                ? const Color.fromARGB(
                                                    255, 167, 167, 0)
                                                : status == "proses"
                                                    ? Colors.blueAccent
                                                    : status == "ditangguhkan"
                                                        ? Colors.red
                                                        : Colors.green;
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _getLaporan[index]
                                                          ["deskripsi"],
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              "Poppins"),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      _getLaporan[index]
                                                          ["created_at"],
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              119,
                                                              119,
                                                              119),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              "Poppins"),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      StringExtentions.ucwords(
                                                          status),
                                                      style: TextStyle(
                                                          color: warnaStatus,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              "Poppins"),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    SizedBox(
                                                      width: 300,
                                                      height: 40,
                                                      child: TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              const Color
                                                                      .fromRGBO(
                                                                  15,
                                                                  76,
                                                                  117,
                                                                  1),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    DetailLaporan(
                                                                        id: _getLaporan[index]
                                                                            [
                                                                            "id"])),
                                                          );
                                                        },
                                                        child: const Text(
                                                          'Detail',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xffffffff),
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        );
                                      })),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
