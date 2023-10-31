// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sp_util/sp_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gastrack/controller/updatedatauserController.dart';
import 'package:gastrack/provider/UserProvider.dart';

class Changename extends StatelessWidget {
  Changename({super.key});

  final UpdateDataUserController _controller = UpdateDataUserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          "Ubah Username",
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          controller: _controller.txtUsername,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Ubah username baru',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Color.fromRGBO(249, 1, 131, 1.0),
                            )),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(249, 1, 131, 1.0),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 122, 122, 122)
                              .withOpacity(0.55), // Warna bayangan
                          spreadRadius: 0, // Seberapa jauh bayangan menyebar
                          blurRadius: 5, // Seberapa kabur bayangan
                          offset: const Offset(0, 4), // Posisi bayangan (x, y)
                        ),
                      ],
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: () {
                        _controller.ChangeName();
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 255, 255),
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
    );
  }
}

class Changeemail extends StatefulWidget {
  const Changeemail({super.key});

  @override
  State<Changeemail> createState() => _MyHomePageState_Changeemail();
}

class _MyHomePageState_Changeemail extends State<Changeemail> {
  final UpdateDataUserController _controller = UpdateDataUserController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          "Ubah Email",
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          controller: _controller.txtEmail,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Ubah email baru',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Color.fromRGBO(249, 1, 131, 1.0),
                            )),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan email baru Anda';
                            } else if (!isValidEmail(value)) {
                              return 'Format email Anda tidak sesuai ketentuan';
                            }
                            return null;
                          },
                          onChanged: (_) {
                            setState(() {
                              _isButtonEnabled =
                                  _formKey.currentState!.validate();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _isButtonEnabled
                          ? const Color.fromRGBO(249, 1, 131, 1.0)
                          : const Color.fromARGB(255, 223, 223, 223),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: _isButtonEnabled
                              ? const Color.fromARGB(255, 122, 122, 122)
                                  .withOpacity(0.55)
                              : const Color.fromARGB(255, 122, 122, 122)
                                  .withOpacity(0),
                          spreadRadius: 0, // Seberapa jauh bayangan menyebar
                          blurRadius: 5, // Seberapa kabur bayangan
                          offset: const Offset(0, 4), // Posisi bayangan (x, y)
                        ),
                      ],
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: _isButtonEnabled
                          ? () {
                              _controller.ChangeEmail();
                            }
                          : null,
                      child: const Text(
                        "Update",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 255, 255),
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
    );
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }
}

class Changephone extends StatefulWidget {
  const Changephone({super.key});

  @override
  State<Changephone> createState() => _MyHomePageState_Changephone();
}

class _MyHomePageState_Changephone extends State<Changephone> {
  final UpdateDataUserController _controller = UpdateDataUserController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;
  List<Map<String, dynamic>> Datauser = [];

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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
    return Datauser.isEmpty
        ? ChangeTelp(context)
        : Datauser[0]['no_hp'] == null
            ? AddTelp(context)
            : ChangeTelp(context);
  }

  Scaffold ChangeTelp(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          "Ubah No. Telp",
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          controller: _controller.txtnotelp,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Container(
                                color: const Color.fromRGBO(249, 1, 131, 1.0),
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: const Text(
                                  "+62",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                )),
                            labelText: '(tidak perlu menulis angka 0 pertama)',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Color.fromRGBO(249, 1, 131, 1.0),
                            )),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan nomor telepon Anda';
                            } else if (value.length < 11) {
                              return 'Nomor telepon minimal 11 digit';
                            } else if (value.length > 14) {
                              return 'Nomor telepon maksimal 14 digit';
                            } else if (value.contains(' ')) {
                              return 'Nomor telepon tidak menggunakan spasi';
                            } else if (value.contains(RegExp(r'[a-z]')) ||
                                value.contains(RegExp(r'[A-Z]')) ||
                                value.contains(RegExp(r'[;\/,.*()=#+_-]'))) {
                              return 'Nomor telepon hanya boleh menggunakan angka';
                            }
                            return null;
                          },
                          onChanged: (_) {
                            setState(() {
                              _isButtonEnabled =
                                  _formKey.currentState!.validate();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _isButtonEnabled
                          ? const Color.fromRGBO(249, 1, 131, 1.0)
                          : const Color.fromARGB(255, 223, 223, 223),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: _isButtonEnabled
                              ? const Color.fromARGB(255, 122, 122, 122)
                                  .withOpacity(0.55)
                              : const Color.fromARGB(255, 122, 122, 122)
                                  .withOpacity(0),
                          spreadRadius: 0, // Seberapa jauh bayangan menyebar
                          blurRadius: 5, // Seberapa kabur bayangan
                          offset: const Offset(0, 4), // Posisi bayangan (x, y)
                        ),
                      ],
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: _isButtonEnabled
                          ? () {
                              _controller.ChangeTelp();
                            }
                          : null,
                      child: const Text(
                        "Update",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 255, 255),
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
    );
  }

  Scaffold AddTelp(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          "Tambahkan No. Telp",
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          controller: _controller.txtnotelp,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Container(
                                color: const Color.fromRGBO(249, 1, 131, 1.0),
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: const Text(
                                  "+62",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                )),
                            labelText: '(tidak perlu menulis angka 0 pertama)',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Color.fromRGBO(249, 1, 131, 1.0),
                            )),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan nomor telepon Anda';
                            } else if (value.length < 11) {
                              return 'Nomor telepon minimal 11 digit';
                            } else if (value.length > 14) {
                              return 'Nomor telepon maksimal 14 digit';
                            } else if (value.contains(' ')) {
                              return 'Nomor telepon tidak menggunakan spasi';
                            } else if (value.contains(RegExp(r'[a-z]')) ||
                                value.contains(RegExp(r'[A-Z]')) ||
                                value.contains(RegExp(r'[;\/,.*()=#+_-]'))) {
                              return 'Nomor telepon hanya boleh menggunakan angka';
                            }
                            return null;
                          },
                          onChanged: (_) {
                            setState(() {
                              _isButtonEnabled =
                                  _formKey.currentState!.validate();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _isButtonEnabled
                          ? const Color.fromRGBO(249, 1, 131, 1.0)
                          : const Color.fromARGB(255, 223, 223, 223),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: _isButtonEnabled
                              ? const Color.fromARGB(255, 122, 122, 122)
                                  .withOpacity(0.55)
                              : const Color.fromARGB(255, 122, 122, 122)
                                  .withOpacity(0),
                          spreadRadius: 0, // Seberapa jauh bayangan menyebar
                          blurRadius: 5, // Seberapa kabur bayangan
                          offset: const Offset(0, 4), // Posisi bayangan (x, y)
                        ),
                      ],
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: _isButtonEnabled
                          ? () {
                              _controller.ChangeTelp();
                            }
                          : null,
                      child: const Text(
                        "Tambahkan",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 255, 255),
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
    );
  }
}

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _MyHomePageState_Changepassword();
}

class _MyHomePageState_Changepassword extends State<Changepassword> {
  final UpdateDataUserController _controller = UpdateDataUserController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;
  bool _isPasswordlamaVisible = true;
  bool _isPasswordbaruVisible = true;
  bool _isConfirmPasswordVisible = true;

  void _togglePasswordLamaVisibility() {
    setState(() {
      _isPasswordlamaVisible = !_isPasswordlamaVisible;
    });
  }

  void _togglePasswordBaruVisibility() {
    setState(() {
      _isPasswordbaruVisible = !_isPasswordbaruVisible;
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
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          "Ubah Password",
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          controller: _controller.txtLastPass,
                          obscureText: _isPasswordlamaVisible,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: _togglePasswordLamaVisibility,
                              child: Icon(
                                _isPasswordlamaVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            labelText: 'Password lama',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Color.fromRGBO(249, 1, 131, 1.0),
                            )),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan kata sandi lama Anda';
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          controller: _controller.txtNewPass,
                          obscureText: _isPasswordbaruVisible,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: _togglePasswordBaruVisibility,
                              child: Icon(
                                _isPasswordbaruVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            labelText: 'Password baru',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Color.fromRGBO(249, 1, 131, 1.0),
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
                          onChanged: (_) {
                            setState(() {
                              _isButtonEnabled =
                                  _formKey.currentState!.validate();
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          controller: _controller.txtConfirmNewPass,
                          obscureText: _isConfirmPasswordVisible,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: _toggleConfirmPasswordVisibility,
                              child: Icon(
                                _isConfirmPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            labelText: 'Konfirmasi password baru',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Color.fromRGBO(249, 1, 131, 1.0),
                            )),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan konfirmasi kata sandi Anda';
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _isButtonEnabled
                          ? const Color.fromRGBO(249, 1, 131, 1.0)
                          : const Color.fromARGB(255, 223, 223, 223),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: _isButtonEnabled
                              ? const Color.fromARGB(255, 122, 122, 122)
                                  .withOpacity(0.55)
                              : const Color.fromARGB(255, 122, 122, 122)
                                  .withOpacity(0),
                          spreadRadius: 0, // Seberapa jauh bayangan menyebar
                          blurRadius: 5, // Seberapa kabur bayangan
                          offset: const Offset(0, 4), // Posisi bayangan (x, y)
                        ),
                      ],
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: _isButtonEnabled
                          ? () {
                              _controller.ChangePass();
                            }
                          : null,
                      child: const Text(
                        "Ubah Password",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 255, 255),
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
    );
  }

  bool isPasswordValid(String password) {
    final RegExp passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9]).{8,}$');
    return passwordRegExp.hasMatch(password);
  }
}
