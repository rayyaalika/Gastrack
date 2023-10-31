// ignore_for_file: file_names, non_constant_identifier_names, depend_on_referenced_packages

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gastrack/provider/Base_provider.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class TransaksiProvider extends BaseProvider {
  Future<Response> getDataTransaksiById(id) async {
    return get('$Url/transaksi/$id', headers: header);
  }

  Future<Response> getDatabelumbayar(id) async {
    return get('$Url/transaksi/belum_bayar/$id', headers: header);
  }

  Future<Response> getDatadiproses(id) async {
    return get('$Url/transaksi/proses/$id', headers: header);
  }

  Future<Response> getDatadikirim(id) async {
    return get('$Url/transaksi/dikirim/$id', headers: header);
  }

  Future<Response> getDataselesai(id) async {
    return get('$Url/transaksi/diterima/$id', headers: header);
  }

  Future<Response> AddPesanan(var data) async {
    return post('$Url/transaksi/create', data, headers: header);
  }

  Future<Response> DeletePesanan(id) async {
    return delete('$Url/transaksi/belum_bayar/$id', headers: header);
  }

  Future<void> uploadImageToApi(PlatformFile file, id) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$Url/update/pembayaran/$id'));

    header.forEach((key, value) {
      request.headers[key] = value;
    });

    // Tambahkan gambar ke request
    request.files.add(http.MultipartFile(
      'bukti_pembayaran', // Ganti dengan nama field yang sesuai di API
      http.ByteStream.fromBytes(
          file.bytes as List<int>), // Gunakan bytes dari PlatformFile
      file.size, // Ukuran file
      filename: file.name, // Nama file
    ));

    try {
      EasyLoading.show();
      var response = await request.send();

      if (response.statusCode == 200) {
        Get.snackbar(
          "Berhasil",
          "bukti pembayaran berhasil diunggah, cek di menu proses!!",
          colorText: Colors.white,
          backgroundColor: Colors.green.withOpacity(0.75),
        );
        Get.offAllNamed('/home');
        EasyLoading.dismiss();
      } else {
        Get.snackbar(
          "Bukti pembayaran gagal diunggah",
          "Ukuran foto max. 2 mb",
          colorText: Colors.white,
          backgroundColor: Colors.red.withOpacity(0.50),
        );
        EasyLoading.dismiss();
      }
    } catch (e) {
      Get.snackbar(
        "Bukti pembayaran gagal diunggah",
        "Terjadi kesalahan: $e",
        colorText: Colors.white,
        backgroundColor: Colors.red.withOpacity(0.50),
      );
      EasyLoading.dismiss();
    }
  }
}
