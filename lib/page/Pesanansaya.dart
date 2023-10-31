// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gastrack/page/DetailPesananSaya/Belumbayarpage.dart';
import 'package:gastrack/page/DetailPesananSaya/Diprosespage.dart';
import 'package:gastrack/page/DetailPesananSaya/Diantarpage.dart';
import 'package:gastrack/page/DetailPesananSaya/Selesaipage.dart';

class PesananSaya extends StatefulWidget {
  const PesananSaya({super.key});

  @override
  State<PesananSaya> createState() => _MyStatefulWidgetState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyStatefulWidgetState extends State<PesananSaya>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 110, horizontal: 15),
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(50.0), // Tinggi TabBar
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(249, 1, 131, 1.0),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: const Color.fromRGBO(128, 38, 198, 1.0),
                        labelColor: const Color.fromARGB(255, 255, 255, 255),
                        labelStyle: const TextStyle(
                          fontSize: 8,
                          fontFamily: 'Poppins-bold',
                        ),
                        tabs: const <Widget>[
                          Tab(
                            text: 'Belum Bayar',
                          ),
                          Tab(
                            text: 'Diproses',
                          ),
                          Tab(
                            text: 'Dikirim',
                          ),
                          Tab(
                            text: 'Selesai',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                body: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15), // Warna bayangan
                        spreadRadius: 0, // Seberapa jauh bayangan menyebar
                        blurRadius: 4, // Seberapa kabur bayangan
                        offset: const Offset(0, 1), // Posisi bayangan (x, y)
                      ),
                    ],
                  ), // Warna latar belakang TabBar
                  child: TabBarView(
                    controller: _tabController,
                    children: const <Widget>[
                      Page1(),
                      Page2(),
                      Page3(),
                      Page4()
                    ],
                  ),
                ),
              )),
          const AppBar(),
        ],
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(249, 1, 131, 1.0),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "Pesanan Saya",
                style: TextStyle(
                  fontFamily: "Poppins-bold",
                  fontSize: 20,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
