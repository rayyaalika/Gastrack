// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gastrack/animations/fadeAnimation.dart';
import 'package:gastrack/controller/Authcontroller.dart';
import '/coverpage.dart';

class RegisEmailPage extends StatefulWidget {
  const RegisEmailPage({super.key});

  @override
  State<RegisEmailPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RegisEmailPage> {
  final RegistrasiController _regitrasiController = RegistrasiController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;
  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(249, 1, 131, 1.0),
                  Color.fromRGBO(128, 38, 198, 1.0)
                ], // Warna gradient
              ),
            ),
          ),
          elevation: 0,
        ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(249, 1, 131, 1.0),
                  Color.fromRGBO(128, 38, 198, 1.0)
                ], // Warna gradient
              ),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    width: double.infinity,
                    height: 550,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(50))),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FadeAnimation(
                                  0.5,
                                  Text(
                                    "Buat Akun Baru",
                                    style: TextStyle(
                                        color: Color.fromRGBO(249, 1, 131, 1.0),
                                        fontFamily: 'Poppins-bold',
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                FadeAnimation(
                                  0.6,
                                  Text(
                                    "Silahkan buat akun baru Anda",
                                    style: TextStyle(
                                        color: Color.fromRGBO(23, 23, 23, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: FadeAnimation(
                                    0.7,
                                    TextFormField(
                                      controller:
                                          _regitrasiController.txtUsername,
                                      decoration: const InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child:
                                              Icon(Icons.account_box_outlined),
                                        ),
                                        labelText: 'Username',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(249, 1, 131, 1.0),
                                        )),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Masukkan username Anda';
                                        }
                                        return null;
                                      },
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                      onChanged: (_) {
                                        setState(() {
                                          _isButtonEnabled =
                                              _formKey.currentState!.validate();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  child: FadeAnimation(
                                    0.8,
                                    TextFormField(
                                      controller: _regitrasiController.txtEmail,
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                      ),
                                      decoration: const InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Icon(Icons.email_outlined),
                                        ),
                                        labelText: 'Email',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(249, 1, 131, 1.0),
                                        )),
                                        border: OutlineInputBorder(),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Masukkan email Anda';
                                        }
                                        if (!isValidEmail(value)) {
                                          return 'sesuaikan dengan format email';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      onChanged: (_) {
                                        setState(() {
                                          _isButtonEnabled =
                                              _formKey.currentState!.validate();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: FadeAnimation(
                                    0.9,
                                    TextFormField(
                                      controller: _regitrasiController.txtPass,
                                      obscureText: _isPasswordVisible,
                                      decoration: InputDecoration(
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Icon(Icons.lock_outline),
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: _togglePasswordVisibility,
                                          child: Icon(
                                            _isPasswordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ),
                                        ),
                                        labelText: 'Kata Sandi',
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 10),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(249, 1, 131, 1.0),
                                        )),
                                        border: const OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Masukkan kata sandi Anda';
                                        }
                                        if (!isPasswordValid(value)) {
                                          return 'Minimal 8 karakter terdiri dari huruf kapital dan angka';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                      onChanged: (_) {
                                        setState(() {
                                          _isButtonEnabled =
                                              _formKey.currentState!.validate();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  child: FadeAnimation(
                                    0.9,
                                    TextFormField(
                                      controller:
                                          _regitrasiController.txtConfirmPass,
                                      obscureText: _isConfirmPasswordVisible,
                                      decoration: InputDecoration(
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Icon(Icons.lock_outline),
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap:
                                              _toggleConfirmPasswordVisibility,
                                          child: Icon(
                                            _isConfirmPasswordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ),
                                        ),
                                        labelText: 'Konfirmasi Kata Sandi',
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 10),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(249, 1, 131, 1.0),
                                        )),
                                        border: const OutlineInputBorder(),
                                      ),
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Masukkan konfirmasi kata sandi yang sama';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      onChanged: (_) {
                                        setState(() {
                                          _isButtonEnabled =
                                              _formKey.currentState!.validate();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
                            child: FadeAnimation(
                              1.5,
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: _isButtonEnabled
                                      ? () {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          _regitrasiController.registrasi();
                                          Navigator.pushReplacement(
                                            context,
                                            PageTransition(
                                              child: const Coverpage(),
                                              type: PageTransitionType.fade,
                                            ),
                                          );
                                        }
                                      : null,
                                  child: const Text(
                                    "Buat Akun",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }

  // Function to validate an email address
  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    // Gunakan ekspresi reguler untuk memeriksa password
    // Minimal 8 karakter, minimal satu huruf kapital, minimal satu angka.
    final RegExp passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9]).{8,}$');
    return passwordRegExp.hasMatch(password);
  }
}
