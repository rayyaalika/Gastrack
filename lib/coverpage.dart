import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gastrack/controller/Authcontroller.dart';
import 'package:rive/rive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Coverpage extends StatefulWidget {
  const Coverpage({super.key});

  @override
  State<Coverpage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Coverpage> {
  final LoginController _loginController = LoginController();
  bool _isPasswordVisible = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.2,
            child: Image.asset("assets/bg/bg.png"),
          ),
          const Positioned.fill(
            child: SizedBox(
              width: 200,
              child: RiveAnimation.asset("assets/rive/shape.riv"),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 40,
                sigmaY: 40,
              ),
              child: const SizedBox(),
            ),
          ),
          Positioned.fill(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Image.asset("assets/icon/logo_text.png"),
                    const Text(
                      "Quickest &",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins-ExtraBold',
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Safest",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins-ExtraBold',
                          fontSize: 40,
                          height: 1.2,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Delivery",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins-ExtraBold',
                          fontSize: 40,
                          height: 1.2,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(249, 1, 131, 1.0),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromRGBO(128, 38, 198, 1.0)
                                    .withOpacity(1.0), // Warna bayangan
                                spreadRadius:
                                    1, // Seberapa jauh bayangan menyebar
                                blurRadius: 1, // Seberapa kabur bayangan
                                offset: const Offset(
                                    4, 0), // Posisi bayangan (x, y)
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Container(
                            width: 250,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(1.0), // Warna bayangan
                                    spreadRadius:
                                        1, // Seberapa jauh bayangan menyebar
                                    blurRadius: 1, // Seberapa kabur bayangan
                                    offset: const Offset(
                                        1, 4), // Posisi bayangan (x, y)
                                  ),
                                ]),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 244, 243, 244),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                onPressed: () {
                                  _showPopupLogin(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 60),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.arrowRight,
                                        color:
                                            Color.fromRGBO(128, 38, 198, 1.0),
                                      ),
                                      Spacer(),
                                      Text(
                                        "GET START",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          color:
                                              Color.fromRGBO(128, 38, 198, 1.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Copyright@2023 Gastrack 1.0.0',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void _showPopupLogin(BuildContext context) async {
    showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: 'Sign In',
        context: context,
        transitionDuration: const Duration(milliseconds: 400),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          Tween<Offset> tween;
          tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
          return SlideTransition(
            position: tween.animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: child,
          );
        },
        pageBuilder: (context, _, __) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Center(
              child: Container(
                height: 550,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 246, 246, 246),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.transparent,
                  body: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          const Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 30),
                                  ),
                                  Text(
                                    "Selamat Datang",
                                    style: TextStyle(
                                        color: Color.fromRGBO(249, 1, 131, 1.0),
                                        fontFamily: 'Poppins-bold',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 30),
                                  ),
                                  Text(
                                    "Masuk menggunakan akun Anda",
                                    style: TextStyle(
                                        color: Color.fromRGBO(47, 47, 47, 1.0),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Form(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _loginController.txtEmail,
                                    decoration: const InputDecoration(
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Icon(Icons.email_outlined),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40)),
                                      ),
                                      labelText: "Email",
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: TextFormField(
                                    controller: _loginController.txtPass,
                                    obscureText: _isPasswordVisible,
                                    decoration: const InputDecoration(
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Icon(Icons.lock_outline),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40)),
                                      ),
                                      labelText: "Kata sandi",
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 34, vertical: 5),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          _isPasswordVisible
                                              ? Icons.check_box_outline_blank
                                              : Icons.check_box_rounded,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          _togglePasswordVisibility();
                                          setState(() {});
                                        },
                                      ),
                                      const Text(
                                        "Tampilkan sandi",
                                        style: TextStyle(
                                            color: Color.fromRGBO(4, 3, 3, 1),
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: 250,
                            height: 50,
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(249, 1, 131, 1.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                _loginController.auth();
                              },
                              child: const Text(
                                "M A S U K",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Belum punya akun?",
                                style: TextStyle(
                                    color: Color.fromRGBO(47, 47, 47, 1.0),
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/registrasi');
                                },
                                child: const Text(
                                  "Klik disini",
                                  style: TextStyle(
                                      color: Color.fromRGBO(128, 38, 198, 1.0),
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Positioned(
                        left: 0,
                        right: 0,
                        bottom: -50,
                        child: Icon(
                          Icons.close_rounded,
                          color: Color.fromARGB(184, 255, 255, 255),
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
