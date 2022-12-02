import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elapor_polije/pages/menus/laporans/detail_laporan.dart';
import 'package:flutter/material.dart';
import 'package:elapor_polije/component/hero_main.dart';
import 'package:elapor_polije/component/drawer.dart';

class Laporan extends StatefulWidget {
  const Laporan({Key? key}) : super(key: key);

  @override
  State<Laporan> createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //Jenis Laporan
  final List<String> jenisLaporan = ['Pengaduan', 'Aspirasi', 'Informasi'];
  String? jenisLaporanSelected;

  // get judul => judul.text;
  // get deskripsiPengaduan => deskripsiPengaduan.text;
  // get dateinput => dateinput.text;
  // get status => status.text;

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
                                'Klarifikasi',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 15),
                              ),
                              const SizedBox(height: 10),
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
                                  'Pilih Jenis Pengaduan',
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
                                  height: 250,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, right: 20.0, left: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Judul Laporan.......'),
                                        Container(
                                          height: 150,
                                          child: Column(
                                            children: <Widget>[
                                              // GetLaporan(
                                              //     judul: judul,
                                              //     deskripsiPengaduan:
                                              //         deskripsiPengaduan,
                                              //     dateinput: dateinput,
                                              //     status: status)
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
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
                                                        const DetailLaporan()),
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
                              const SizedBox(height: 30),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(6)),
                                padding: const EdgeInsets.all(10),
                                child: const Text('Judul Laporan....'),
                              )
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            )));
  }
}

// rencana mau bikin buat ngambil data dari detail laporan buat di tampilin ke laporan
// tapi belum nemu cara

// getLaporan(judul,deskripsiPengaduan,dateinput,status){
//   print(judul);
//   print(deskripsiPengaduan);
//   print(dateinput);
//   print(status);
// }

class GetLaporan extends StatelessWidget {
  String judul, deskripsiPengaduan, dateinput, status;
  GetLaporan(
      {required this.judul,
      required this.deskripsiPengaduan,
      required this.dateinput,
      required this.status});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${judul}'),
        Text('${deskripsiPengaduan}'),
        Text('${dateinput}'),
        Text('${status}')
      ],
    );
  }
}
