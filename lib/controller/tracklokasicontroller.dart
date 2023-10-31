// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TracklokasiController extends GetxController {
  TextEditingController txtkodepengiriman = TextEditingController();

  void trackingLokasi() {
    String kode = txtkodepengiriman.text;
    print("kode pengiriman: " + kode);
  }
}
