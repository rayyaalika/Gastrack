// ignore_for_file: depend_on_referenced_packages, file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gastrack/animations/fadeAnimation.dart';
import 'package:gastrack/controller/Authcontroller.dart';
import 'package:gastrack/page/notfoundpage.dart';
import 'package:gastrack/provider/UserProvider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sp_util/sp_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'setting/setting_akun.dart';

class Profilsaya extends StatefulWidget {
  const Profilsaya({super.key});

  @override
  State<Profilsaya> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Profilsaya> {
  final LogoutController _controller = LogoutController();
  List<Map<String, dynamic>> Datauser = [];
  late var message = "";

  @override
  void initState() {
    UserProvider().getDatauser(SpUtil.getInt('id')).then((value) {
      if (value.statusCode == 200) {
        var data = value.body['datauser'];
        setState(() {
          Datauser.add(data);
        });
        EasyLoading.dismiss();
      }
    });
    super.initState();
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Dialog tidak bisa ditutup dengan mengetuk di luar dialog
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                20.0), // Atur BorderRadius sesuai kebutuhan
          ),
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin melanjutkan?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
            ),
            TextButton(
                child: const Text('Ya'),
                onPressed: () {
                  _controller.logout();
                }),
          ],
        );
      },
    );
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
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25), // Warna bayangan
                    spreadRadius: 0, // Seberapa jauh bayangan menyebar
                    blurRadius: 4, // Seberapa kabur bayangan
                    offset: const Offset(0, 1), // Posisi bayangan (x, y)
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FadeAnimation(
                      0.5,
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 350,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FadeAnimation(
                              0.5,
                              Container(
                                width: double.infinity,
                                height: 60,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Akun',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            FadeAnimation(
                              0.5,
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: Changename(),
                                          type: PageTransitionType.rightToLeft,
                                        ));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          FaIcon(FontAwesomeIcons.solidUser,
                                              size: 20, color: Colors.black),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Username',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Datauser.isEmpty
                                              ? const Text("")
                                              : Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    Datauser[0]['name'],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 10,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black26),
                                                  ),
                                                ),
                                          Image.asset(
                                            "assets/icon/navigate_icon.png",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            FadeAnimation(
                              0.6,
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const Changeemail(),
                                          type: PageTransitionType.rightToLeft,
                                        ));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.email,
                                              size: 20, color: Colors.black),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Email',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Datauser.isEmpty
                                              ? const Text("")
                                              : Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    Datauser[0]['email'],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 10,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black26),
                                                  ),
                                                ),
                                          Image.asset(
                                            "assets/icon/navigate_icon.png",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            FadeAnimation(
                              0.6,
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: const Changephone(),
                                          type: PageTransitionType.rightToLeft,
                                        ));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.phone,
                                              size: 20, color: Colors.black),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'No. Telp',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Datauser.isEmpty
                                              ? const Text("")
                                              : Datauser[0]['no_hp'] == null
                                                  ? const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: Text(
                                                        'Atur no. telp',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Poppins',
                                                            color:
                                                                Colors.black26),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: Text(
                                                        Datauser[0]['no_hp'],
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 10,
                                                            fontFamily:
                                                                'Poppins',
                                                            color:
                                                                Colors.black26),
                                                      ),
                                                    ),
                                          Image.asset(
                                            "assets/icon/navigate_icon.png",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            FadeAnimation(
                              0.7,
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        child: const Changepassword(),
                                        type: PageTransitionType.rightToLeft,
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.lock,
                                              size: 20, color: Colors.black),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Ubah Password',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                        "assets/icon/navigate_icon.png",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            FadeAnimation(
                              0.7,
                              Container(
                                width: double.infinity,
                                height: 60,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Setting',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            FadeAnimation(
                              0.8,
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        child: const NotFoundPage(),
                                        type: PageTransitionType.rightToLeft,
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.help_outline_outlined,
                                              size: 20, color: Colors.black),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Pusat Bantuan',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                        "assets/icon/navigate_icon.png",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            FadeAnimation(
                              0.8,
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        child: const NotFoundPage(),
                                        type: PageTransitionType.rightToLeft,
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.security_outlined,
                                              size: 20, color: Colors.black),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Kebijakan Gastrack',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                        "assets/icon/navigate_icon.png",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            FadeAnimation(
                              0.9,
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        child: const NotFoundPage(),
                                        type: PageTransitionType.rightToLeft,
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.contact_page_outlined,
                                              size: 20, color: Colors.black),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Kontak Kami',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                        "assets/icon/navigate_icon.png",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            FadeAnimation(
                              0.9,
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        child: const NotFoundPage(),
                                        type: PageTransitionType.rightToLeft,
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.flag,
                                              size: 20, color: Colors.black),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Laporkan Masalah',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                fontFamily: 'Poppins',
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                        "assets/icon/navigate_icon.png",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: FadeAnimation(
                        1.0,
                        Container(
                          width: 350,
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                            ),
                            onPressed: () {
                              _showConfirmationDialog(context);
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Keluar",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.logout_outlined,
                                  size: 15,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
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
                      "Profil Saya",
                      style: TextStyle(
                        fontFamily: "Poppins-bold",
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
