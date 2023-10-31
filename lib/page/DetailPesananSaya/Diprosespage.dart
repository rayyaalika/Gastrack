// ignore_for_file: file_names, non_constant_identifier_names, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:gastrack/animations/fadeAnimation.dart';
import 'package:gastrack/page/DetailPesananSaya/Belumbayarpage.dart';
import 'package:gastrack/page/detail_transaksi.dart';
import 'package:gastrack/provider/TransaksiProvider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sp_util/sp_util.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Belumbayarpage();
  }
}

class Belumbayarpage extends StatefulWidget {
  const Belumbayarpage({super.key});

  @override
  State<Belumbayarpage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Belumbayarpage> {
  final List<Map> DataPesanan = [];
  bool _notResponding = false;
  var message = "";

  void getData() {
    EasyLoading.show();
    TransaksiProvider().getDatadiproses(SpUtil.getInt('id')).then((value) {
      if (value.statusCode == 200) {
        var data = value.body['datauser'];
        if (data == null) {
          setState(() {
            message = "Pesanan Belum Ada";
          });
        } else {
          for (var element in data) {
            setState(() {
              DataPesanan.add(element);
            });
          }
        }
        EasyLoading.dismiss();
      } else if (value.hasError == true) {
        var pesan = "Gagal Memuat, hubungkan perangkat ke jaringan";
        setState(() {
          message = pesan;
          _notResponding = true;
        });
        EasyLoading.dismiss();
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DataPesanan.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              tidakadapesanan(
                message: message,
              ),
              _notResponding == true ? butonReload() : const Text(""),
            ],
          )
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: DataPesanan.map((index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: DetailTransaksi(
                              id: index['id_transaksi'],
                            ),
                            type: PageTransitionType.rightToLeft,
                          ),
                        );
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeAnimation(
                              0.9,
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/icon/proses_icon.png',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    width: 250,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${index['nama_agen']}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${index['jumlah_transaksi']} Pcs ${index['nama_gas']}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          "Kategori: ${index['jenis_gas']}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          "Pesanan Sedang Diproses",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${index['tanggal_transaksi']}",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            FadeAnimation(
                                              0.6,
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(
                                                  "Rp${index['total_transaksi']}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromRGBO(
                                                        249, 1, 131, 1.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              }).toList(),
            ));
  }

  InkWell butonReload() {
    return InkWell(
      onTap: () {
        getData();
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        width: 150,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.refresh_rounded,
              color: Colors.grey.shade100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Muat ulang',
                style: TextStyle(
                    fontFamily: 'Poppins', color: Colors.grey.shade100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
