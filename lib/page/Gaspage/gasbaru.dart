// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gastrack/animations/fadeAnimation.dart';
import 'package:gastrack/page/Gaspage/isiulanggas.dart';
import 'package:gastrack/page/detail_produk.dart';
import 'package:gastrack/provider/GasProvider.dart';
import 'package:page_transition/page_transition.dart';

class BaruPage extends StatefulWidget {
  const BaruPage({super.key});

  @override
  State<BaruPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<BaruPage> {
  List<Map<String, dynamic>> Gas = [];

  @override
  void initState() {
    GasProvider().getDataGas().then((value) {
      if (value.statusCode == 200) {
        var data = value.body['data'];
        for (var element in data) {
          if (element['jenis_gas'] == 'Gas Baru') {
            setState(() {
              Gas.add(element);
            });
          }
        }
      } else if (value.hasError == true) {
        var pesan = "Gagal Memuat, hubungkan perangkat ke jaringan";
        Flushbar(
          backgroundColor: Colors.red,
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.all(10),
          borderRadius: BorderRadius.circular(8),
          message: pesan,
          icon: const Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.white,
          ),
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(249, 1, 131, 1.0),
              Color.fromRGBO(128, 38, 198, 1.0)
            ],
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(71, 109, 109, 109)
                                .withOpacity(0.15),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Beli Gas Baru',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                              fontFamily: 'Poppins-bold',
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SizedBox(
                child: Gas.isEmpty
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          LoadingPage(),
                          LoadingPage(),
                          LoadingPage(),
                        ],
                      )
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: Gas.map((index) {
                            return Column(
                              children: [
                                menu_gas(
                                    index), // Garis pemisah antara setiap entri
                              ],
                            );
                          }).toList(),
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell menu_gas(index) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              child: DetailProduk(
                id: index['id_gas'],
              ),
              type: PageTransitionType.rightToLeft,
            ),
          );
        },
        child: (index['berat_gas'] == 3)
            ? content(index, 'assets/icon/gasGreen_icon.png')
            : (index['berat_gas'] == 5.5)
                ? content(index, 'assets/icon/gasPink_icon.png')
                : content(index, 'assets/icon/gasPurple_icon.png'));
  }

  Container content(index, img) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      padding: const EdgeInsets.symmetric(vertical: 30),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 122, 122, 122)
                .withOpacity(0.25), // Warna bayangan
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          img,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${index['name_gas']} (${index['berat_gas']} Kg) ",
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rp ${index['harga_gas']}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(249, 1, 131, 1.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
