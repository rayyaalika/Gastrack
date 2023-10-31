// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class BaseProvider extends GetConnect {
  var host = "192.168.1.5:8000";
  var Url = "";
  var Urltransaksiuser = "";
  var Urlupdatedatauser = "";
  var Urldata = "";
  var UrlImage = "";
  var header = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SpUtil.getString('token')!}'
  };

  BaseProvider() {
    Urldata = "http://$host/api/data";
    Url = "http://$host/api/agen";
    Urltransaksiuser = "http://$host/api/agen/transaksi";
    Urlupdatedatauser = "http://$host/api/agen/update";
    UrlImage = "http://$host/img/BuktiPembayaran";
  }
}
