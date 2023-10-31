// ignore_for_file: depend_on_referenced_packages, unused_import, file_names

import 'package:flutter/material.dart';
import 'package:gastrack/provider/AuthProvider.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sp_util/sp_util.dart';

class LoginController extends GetxController {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  bool obscureText = true;

  void auth() {
    // String a = "a";
    // String b = "b";

    String email = txtEmail.text;
    String pass = txtPass.text;

    if (email.isEmpty || pass.isEmpty) {
      Get.snackbar(
        "Login Failed",
        "Please input field!",
        backgroundColor: const Color.fromARGB(90, 255, 17, 0),
        colorText: Colors.white,
      );
    } else {
      // if (email == a && pass == b) {
      //   SpUtil.putInt('id', 0);
      //   SpUtil.putString('token', 'token');
      //   SpUtil.putBool('agen', true);
      //   Get.offAllNamed('/home');
      // }
      EasyLoading.show();
      var data = {
        "email": email,
        "password": pass,
      };
      LoginProvider().auth(data).then((value) {
        if (value.statusCode == 200) {
          var data = value.body['datauser'];
          var token = value.body['token'];
          Get.snackbar(
            "Successs",
            "Login Berhasil",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          SpUtil.putInt('id', data['id_agen']);
          // SpUtil.putString('name', data['name']);
          SpUtil.putString('token', token);
          // print(token);
          // print(data);
          // print(Datauser);
          SpUtil.putBool('agen', true);
          Get.offAllNamed('/home');
        } else if (value.statusCode == 422) {
          Get.snackbar(
            "Login gagal",
            value.body['message'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else if (value.hasError == true) {
          Get.snackbar(
            "Server Not Responding",
            'Gagal menghubungka ke server',
            colorText: Colors.white,
          );
        }
        EasyLoading.dismiss();
      });
    }
  }
}

class RegistrasiController extends GetxController {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  TextEditingController txtConfirmPass = TextEditingController();
  TextEditingController txtUsername = TextEditingController();
  bool obscureText = true;

  void registrasi() {
    String email = txtEmail.text;
    String name = txtUsername.text;
    String pass = txtPass.text;
    String konfirmasiPass = txtConfirmPass.text;
    EasyLoading.show();
    var data = {
      "name": name,
      "email": email,
      "password": pass,
      "password_confirmation": konfirmasiPass
    };
    RegistrasiProvider().attempt(data).then((value) {
      if (value.statusCode == 200) {
        Get.snackbar(
          "Successs",
          value.body['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed('/cover');
      } else if (value.statusCode == 422) {
        Get.snackbar(
          "Ragistrasi gagal",
          value.body['message'],
          backgroundColor: Colors.red.shade300,
          colorText: Colors.white,
        );
      } else if (value.hasError == true) {
        Get.snackbar(
          "Server Not Responding",
          'Gagal menghubungka ke server',
          colorText: Colors.white,
        );
      }
      EasyLoading.dismiss();
    });
  }
}

class LogoutController extends GetxController {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  bool obscureText = true;

  void logout() {
    // SpUtil.clear();
    // Get.offAllNamed('/cover');
    EasyLoading.show();
    var data = {
      "token": SpUtil.getString('token')!,
    };
    LogoutProvider().logout(data).then((value) {
      if (value.statusCode == 200) {
        SpUtil.clear();
        Get.offAllNamed('/cover');
      }
      EasyLoading.dismiss();
    });
  }
}
