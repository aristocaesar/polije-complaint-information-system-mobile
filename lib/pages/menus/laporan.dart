import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elapor_polije/pages/menus/laporans/detail_laporan.dart';
import 'package:flutter/material.dart';
import 'package:elapor_polije/component/hero_main.dart';
import 'package:elapor_polije/component/drawer.dart';

class Laporan extends StatefulWidget {
  const Laporan({Key? key}) : super(key: key);
  static const nameRoute = "/laporan";

  @override
  State<Laporan> createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //Jenis Laporan
  final List<String> jenisLaporan = ['Pengaduan', 'Aspirasi', 'Informasi'];
  String? jenisLaporanSelected;

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
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, right: 20.0, left: 20.0),
                          child: ListView(
                            children: [
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
                                },
                                onSaved: (value) {
                                  jenisLaporanSelected = value.toString();
                                },
                              ),
                              const SizedBox(height: 30),
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 300,
                                          height: 40,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      15, 76, 117, 1),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const DetailLaporan(
                                                            id: "ADU1992112335")),
                                              );
                                            },
                                            child: const Text(
                                              'Detail',
                                              style: TextStyle(
                                                  color: Color(0xffffffff),
                                                  fontSize: 12,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            )));
  }
}
