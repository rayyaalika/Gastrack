// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:gastrack/provider/TransaksiProvider.dart';
import 'package:gastrack/provider/UserProvider.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sp_util/sp_util.dart';
import 'package:file_picker/file_picker.dart';

class TransaksiController extends GetxController {
  PlatformFile? photoprofile;
  var id = SpUtil.getInt('id')!;

  void Cancelpesanan(id) {
    EasyLoading.show();
    TransaksiProvider().DeletePesanan(id).then((value) {
      if (value.statusCode == 200) {
        EasyLoading.dismiss();
        Get.snackbar(
          "Success",
          "Pesanan dibatalkan",
          backgroundColor: Colors.green.withOpacity(0.85),
          colorText: Colors.white,
        );
        Get.offAllNamed('/pesanansaya');
      }
    });
  }

  void Addpesanan(id_gas, jumlahTotal) {
    EasyLoading.show();
    UserProvider().getDatauser(id).then((value) {
      if (value.statusCode == 200) {
        var data = value.body['datauser'];
        var koordinat = data['koordinat'];
        if (koordinat == null) {
          Get.snackbar(
            "Pemesanan Gagal",
            "untuk melakukan pemesanan Anda perlu mengatur alamat terlebih dahulu",
            colorText: Colors.white,
            backgroundColor: Colors.red.withOpacity(0.50),
          );
          Get.offAllNamed('/home');
        } else {
          var data = {
            "id_agen": id,
            "id_gas": id_gas,
            "jumlah_transaksi": jumlahTotal,
          };
          TransaksiProvider().AddPesanan(data).then((value) {
            print(value.statusCode);
            if (value.statusCode == 200) {
              Get.snackbar(
                "Success",
                "Pesanan Ditambahkan",
                backgroundColor: Colors.green.withOpacity(0.85),
                colorText: Colors.white,
              );
              Get.toNamed('/pesanansaya');
            }
          });
        }
      } else if (value.hasError == true) {
        Get.snackbar(
          "Pesanan Gagal diproses",
          'Gagal menghubungka ke server',
          colorText: Colors.white,
        );
      }
      EasyLoading.dismiss();
    });
  }

  void Pembayaran(id) {
    print(id.toString());
    print(photoprofile?.size);
    TransaksiProvider().uploadImageToApi(photoprofile!, id);
  }
}

// PlatformFile(path /data/user/0/com.example.gastrack/cache/file_picker/images.jpeg, name: images.jpeg, bytes: null, readStream: null, size: 4452
