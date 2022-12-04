import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elapor_polije/pages/menus/informasi.dart';
import 'package:elapor_polije/pages/menus/laporan.dart';
import 'package:flutter/material.dart';
import 'package:elapor_polije/component/hero_main.dart';
import 'package:elapor_polije/component/drawer.dart';
import 'package:intl/intl.dart';

class DetailLaporan extends StatefulWidget {
  const DetailLaporan({Key? key}) : super(key: key);

  @override
  State<DetailLaporan> createState() => _DetailLaporanState();
}

class _DetailLaporanState extends State<DetailLaporan> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // //form state
  // final _formKey = GlobalKey<FormState>();
  //form state
  final TextEditingController judul = TextEditingController();
  final TextEditingController deskripsiPengaduan = TextEditingController();
  final TextEditingController kategori = TextEditingController();
  final TextEditingController divisi = TextEditingController();
  final TextEditingController status = TextEditingController();
  final TextEditingController dateinput = TextEditingController();
  final TextEditingController deskripsiTanggapan = TextEditingController();
  // list status
  final List<String> kategoriItems = [
    'Kesehatan',
    'Lingkungan',
    'Kenyamanan Pembelajaran',
    'Dan lain-lain'
  ];
  String? kategoriSelected;
  // status
  final List<String> statusItems = [
    'Mahasiswa / Mahasiswi',
    'Dosen',
    'Staf',
    'Masyarakat',
  ];
  String? statusSelected;

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
                HeroComponent(title: "Detail Laporan", drawer: _scaffoldKey),
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
                              const SizedBox(height: 10),
                              const Text(
                                "Judul",
                                style: TextStyle(
                                    fontFamily: 'Poppins', fontSize: 17),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: judul,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(15),
                                  hintText: "Ketikkan Judul",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
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
                              DropdownButtonFormField2(
                                searchController: kategori,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                isExpanded: true,
                                hint: const Text(
                                  'Pilih Jenis Kategori',
                                  style: TextStyle(fontSize: 15),
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
                                items: kategoriItems
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
                                  kategoriSelected = value.toString();
                                },
                                onSaved: (value) {
                                  kategoriSelected = value.toString();
                                },
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
                                  selectFile();
                                },
                                child: const Text(
                                  'Tampilkan Lampiran',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 67, 151, 219)),
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
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 20, left: 30),
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Text(
                                  DateFormat('yyyy-MM-dd KK:mm:ss a')
                                      .format(DateTime.now()),
                                  style: const TextStyle(
                                      fontSize: 17, color: Colors.grey),
                                ),
                              ),
                              // TextField(
                              //   controller: dateinput,
                              //   decoration: InputDecoration(
                              //     border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(5.0)),
                              //   ),
                              //   readOnly: true,
                              //   onTap: () async {
                              //     DateTime? pickedDate = await showDatePicker(
                              //         context: context,
                              //         initialDate: DateTime.now(),
                              //         firstDate: DateTime(2000, 1, 2, 0, 0, 0),
                              //         lastDate: DateTime(2101, 1, 2, 0, 0, 0));

                              //     if (pickedDate != null) {
                              //       String formattedDate =
                              //           DateFormat('dd-MM-yyyy KK:mm:ss')
                              //               .format(pickedDate);
                              //       setState(() {
                              //         dateinput.text =
                              //             formattedDate; //set output date to TextField value.
                              //       });
                              //     }
                              //   },
                              // ),
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
                                // statesController: lampiranTanggapan,
                                style: const ButtonStyle(
                                    alignment: Alignment.centerLeft,
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.zero)),
                                // controller: _passwordController,
                                onPressed: () {},
                                child: const Text(
                                  'Tampilkan Lampiran',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 67, 151, 219)),
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
                                      if (submitlaporanedit(
                                          judul.text,
                                          deskripsiPengaduan.text,
                                          kategoriSelected.toString(),
                                          divisi.text,
                                          status.text,
                                          dateinput.text,
                                          deskripsiTanggapan.text)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text('Kembali ke menu laporan'),
                                        ));
                                        Timer(
                                            const Duration(seconds: 1),
                                            () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Laporan()),
                                                ));
                                      }
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

// Future pickDateTime() async {
//   DateTime? date = await pickDate();
//   if (date == null) return;
// }

// Future<DateTime?> pickDate() => showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: (2100));
// //
// future<TimeOfDay?> pickTime() => showTimePicker(
//   context: context,
//   initialTime: TimeOfDay(hour: hour, minute: minute, second))

submitlaporanedit(String judul, String deskripsiPengaduan, String kategori,
    String divisi, String status, String dateinput, String deskripsiTanggapan) {
  // print(judul);
  // print(deskripsiPengaduan);
  // print(kategori);
  // print(divisi);
  // print(status);
  // print(dateinput);
  // print(deskripsiTanggapan);
  return true;
}