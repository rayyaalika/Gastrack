// ignore_for_file: non_constant_identifier_names, unnecessary_import, depend_on_referenced_packages, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gastrack/animations/fadeAnimation.dart';
import 'package:gastrack/page/Gaspage/gasbaru.dart';
// import 'package:gastrack/page/detail_produk.dart';
import 'package:gastrack/page/Gaspage/isiulanggas.dart';
import 'package:gastrack/provider/UserProvider.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:ui';
import 'package:sp_util/sp_util.dart';
import 'package:page_transition/page_transition.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:gastrack/page/detail_transaksi.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  List<Map<String, dynamic>> Datauser = [];
  late var message = "";
  bool gagalmemuat = false;

  void GetData() {
    setState(() {
      gagalmemuat = false;
    });
    UserProvider().getDatauser(SpUtil.getInt('id')).then((value) {
      if (value.statusCode == 200) {
        var data = value.body['datauser'];
        setState(() {
          Datauser.add(data);
        });
        EasyLoading.dismiss();
        if (data['koordinat'] == null) {
          _showPopupTrack(context);
        }
      } else if (value.hasError == true) {
        var pesan = "Gagal Memuat, hubungkan perangkat ke jaringan";
        setState(() {
          message = pesan;
          gagalmemuat = !gagalmemuat;
        });
        Flushbar(
          backgroundColor: Colors.red,
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.all(10),
          borderRadius: BorderRadius.circular(8),
          message: message,
          icon: const Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.white,
          ),
          duration: const Duration(seconds: 3),
        ).show(context);
        EasyLoading.dismiss();
      }
    });
  }

  @override
  void initState() {
    GetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 110, horizontal: 15),
            child: FadeAnimation(
              0.5,
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: _content(context),
              ),
            ),
          ),
          const Appbar(),
        ],
      ),
    );
  }

  SingleChildScrollView _content(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeAnimation(
              0.6,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Datauser.isEmpty
                      ? gagalmemuat
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(
                                            255, 189, 189, 189)
                                        .withOpacity(0.25), // Warna bayangan
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Gagal Memuat',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: InkWell(
                                      onTap: () {
                                        GetData();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                      255, 189, 189, 189)
                                                  .withOpacity(
                                                      0.15), // Warna bayangan
                                              spreadRadius: 1,
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        child: const Icon(
                                          Icons.refresh_rounded,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Shimmer.fromColors(
                              baseColor:
                                  const Color.fromARGB(255, 241, 241, 241),
                              highlightColor:
                                  const Color.fromARGB(255, 252, 252, 252),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 3),
                                  child: Image.asset(
                                    "assets/icon/pin_logo.png",
                                    width: 15,
                                  ),
                                ),
                                Text(
                                  'Lokasi',
                                  style: TextStyle(
                                    fontFamily: 'Poppins-bold',
                                    fontSize: 14,
                                    color:
                                        const Color.fromARGB(255, 125, 125, 125)
                                            .withOpacity(0.50),
                                  ),
                                ),
                              ],
                            ),
                            defaultlokasi(context)
                          ],
                        ),
                  FadeAnimation(
                    0.7,
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          height: MediaQuery.of(context).size.height * 0.20,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(128, 38, 198, 1.0),
                                Color.fromRGBO(249, 1, 131, 1.0),
                              ], // Warna gradient
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                        ),
                        Datauser.isEmpty
                            ? const PageLoading()
                            : PageDataAgen(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: const FadeAnimation(
                    0.8,
                    Text(
                      'Menu',
                      style: TextStyle(
                        fontFamily: 'Poppins-bold',
                        fontSize: 14,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
                FadeAnimation(
                  0.9,
                  Row(
                    children: [
                      Expanded(
                        child: FractionallySizedBox(
                          widthFactor: 1.0, // Bagi lebar menjadi dua
                          child: Container(
                            margin:
                                const EdgeInsets.only(bottom: 40, right: 10),
                            height: 225,
                            width: MediaQuery.of(context).size.width - 250,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.withOpacity(0.25),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: const IsiUlangPage(),
                                    type: PageTransitionType.rightToLeft,
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icon/gas_icon_home.png",
                                    width: 100,
                                  ),
                                  const Text(
                                    'Isi Ulang Gas',
                                    style: TextStyle(
                                      fontFamily: 'Poppins-bold',
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FractionallySizedBox(
                          widthFactor: 1.0, // Bagi lebar menjadi dua
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 40, left: 10),
                            height: 225,
                            width: MediaQuery.of(context).size.width - 250,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.withOpacity(0.25),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: const BaruPage(),
                                    type: PageTransitionType.rightToLeft,
                                  ),
                                );

                                // Navigator.push(
                                //   context,
                                //   PageTransition(
                                //     child: DetailProduk(
                                //       id: 0,
                                //     ),
                                //     type: PageTransitionType.rightToLeft,
                                //   ),
                                // );
                                // Navigator.push(
                                //   context,
                                //   PageTransition(
                                //     child: const DetailTransaksi(
                                //       id: 1,
                                //     ),
                                //     type: PageTransitionType.rightToLeft,
                                //   ),
                                // );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icon/gas_icon_home.png",
                                    width: 100,
                                  ),
                                  const Text(
                                    'Beli Gas Baru',
                                    style: TextStyle(
                                      fontFamily: 'Poppins-bold',
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container PageDataAgen(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 60),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(236, 255, 255, 255),
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 122, 122, 122)
                .withOpacity(0.25), // Warna bayangan
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nama Agen',
                style: TextStyle(
                  fontFamily: 'Poppins-bold',
                  fontSize: 12,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              Text(
                "Agen " + Datauser[0]['name'],
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.50),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Level Akun',
                  style: TextStyle(
                    fontFamily: 'Poppins-bold',
                    fontSize: 12,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/icon/silver.png",
                      width: 20,
                    ),
                    Text(
                      'Silver',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: const Color.fromARGB(255, 0, 0, 0)
                            .withOpacity(0.50),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Detail Alamat',
                    style: TextStyle(
                      fontFamily: 'Poppins-bold',
                      fontSize: 12,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 3,
                    ),
                    child: Image.asset(
                      "assets/icon/pin_logo.png",
                      width: 10,
                    ),
                  ),
                ],
              ),
              (Datauser[0]['koordinat'] == null)
                  ? buttonAddalamat(context)
                  : FutureBuilder<Widget>(
                      future: getdetailAlamat(Datauser[0]['koordinat']),
                      builder: (BuildContext context,
                          AsyncSnapshot<Widget> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return snapshot.data ?? buttonAddalamat(context);
                        } else {
                          return buttonAddalamat(context);
                        }
                      },
                    ),
            ],
          ),
        ],
      ),
    );
  }

  InkWell defaultlokasi(BuildContext context) {
    return InkWell(
      onTap: () {
        _showPopupTrack(context);
      },
      child: Row(
        children: [
          (Datauser[0]['koordinat'] == null)
              ? const Text(
                  'Madiun, Indonesia',
                  style: TextStyle(
                    fontFamily: 'Poppins-bold',
                    fontSize: 12,
                    color: Color.fromRGBO(128, 38, 198, 1.0),
                  ),
                )
              : FutureBuilder<Widget>(
                  future: getAlamat(Datauser[0]['koordinat']),
                  builder:
                      (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return snapshot.data ?? defaultlokasi(context);
                    } else {
                      return const Text(
                        'Madiun, Indonesia',
                        style: TextStyle(
                          fontFamily: 'Poppins-bold',
                          fontSize: 12,
                          color: Color.fromRGBO(128, 38, 198, 1.0),
                        ),
                      );
                    }
                  },
                ),
          Padding(
            padding: const EdgeInsets.only(
              left: 5,
            ),
            child: Icon(
              Icons.expand_circle_down_outlined,
              color: const Color.fromARGB(255, 125, 125, 125).withOpacity(0.50),
            ),
          ),
        ],
      ),
    );
  }

  Text Textalamat() {
    return Text(
      Datauser[0]['alamat'],
      textAlign: TextAlign.start,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 10,
        color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.50),
      ),
    );
  }

  InkWell buttonAddalamat(BuildContext context) {
    return InkWell(
      onTap: () {
        _showPopupTrack(context);
      },
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: 2,
            ),
            child: Icon(
              Icons.add,
              color: Colors.black45,
              size: 12,
            ),
          ),
          Text(
            'Tambahkan alamat',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }

  void _showPopupTrack(BuildContext context) async {
    showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: 'Alamat',
        context: context,
        transitionDuration: const Duration(milliseconds: 500),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          Tween<Offset> tween;
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
          return SlideTransition(
            position: tween.animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: child,
          );
        },
        pageBuilder: (context, _, __) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Datauser[0]['koordinat'] == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 200,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 246, 246, 246),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Scaffold(
                          resizeToAvoidBottomInset: false,
                          backgroundColor: Colors.transparent,
                          body: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        "Tambahkan Lokasi Anda",
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                249, 1, 131, 1.0),
                                            fontFamily: 'Poppins-bold',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        "Tambahkan untuk lokasi Anda agar mempermudah proses pengiriman barang",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(47, 47, 47, 1.0),
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 19),
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(
                                              249, 1, 131, 1.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          Navigator.pop(context);
                                          Navigator.pushNamed(context, '/maps');
                                        },
                                        child: const Row(
                                          children: [
                                            Icon(Icons
                                                .add_location_alt_outlined),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              child: Text(
                                                "ketuk untuk menambahkan lokasi",
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                  color: Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 200,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 246, 246, 246),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Scaffold(
                          resizeToAvoidBottomInset: false,
                          backgroundColor: Colors.transparent,
                          body: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        "Ubah Lokasi Anda",
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                249, 1, 131, 1.0),
                                            fontFamily: 'Poppins-bold',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      width: double.infinity,
                                      child: FutureBuilder<Widget>(
                                        future: getdetailAlamat(
                                            Datauser[0]['koordinat']),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<Widget> snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return snapshot.data ??
                                                const Text(
                                                    "Memuat Lokasi Anda");
                                          } else {
                                            return const Text(
                                                "Memuat lokasi Anda");
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(
                                              249, 1, 131, 1.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          Navigator.pop(context);
                                          Navigator.pushNamed(context, '/maps');
                                        },
                                        child: const Row(
                                          children: [
                                            Icon(Icons
                                                .edit_location_alt_outlined),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              child: Text(
                                                "ketuk untuk mengubah lokasi",
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                  color: Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
          });
        });
  }
}

Future<Widget> getAlamat(String Latlong) async {
  List<String> koordinatSplit = Latlong.split(', ');

  double latitude = double.parse(koordinatSplit[0]);
  double longitude = double.parse(koordinatSplit[1]);
  List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);
  Placemark address = placemarks[0];
  String alamat =
      "${address.subAdministrativeArea}, ${address.administrativeArea}, ${address.country}";
  return Text(
    alamat,
    style: const TextStyle(
      fontFamily: 'Poppins-bold',
      fontSize: 12,
      color: Color.fromRGBO(128, 38, 198, 1.0),
    ),
  );
}

Future<Widget> getdetailAlamat(String Latlong) async {
  List<String> koordinatSplit = Latlong.split(', ');

  double latitude = double.parse(koordinatSplit[0]);
  double longitude = double.parse(koordinatSplit[1]);
  List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);
  Placemark address = placemarks[0];
  String alamat =
      "${address.street}, ${address.subLocality}, ${address.locality}, ${address.subAdministrativeArea}, ${address.administrativeArea}, ${address.country}";
  return Text(
    alamat,
    style: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 10,
      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.50),
    ),
  );
}

class PageLoading extends StatelessWidget {
  const PageLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 60),
        height: MediaQuery.of(context).size.height * 0.20,
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(212, 241, 241, 241),
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(236, 255, 255, 255), // Warna bayangan
                spreadRadius: 0,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 241, 241, 241),
            highlightColor: const Color.fromARGB(255, 252, 252, 252),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class Appbar extends StatelessWidget {
  const Appbar({
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
                "Beranda",
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
