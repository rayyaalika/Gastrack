// ignore_for_file: file_names

import 'package:gastrack/provider/Base_provider.dart';
import 'package:get/get.dart';

class GasProvider extends BaseProvider {
  Future<Response> getDataGas() async {
    return get('$Urldata/gas', headers: header);
  }

  Future<Response> getDataGasById(id) async {
    return get('$Urldata/gas/$id', headers: header);
  }
}
