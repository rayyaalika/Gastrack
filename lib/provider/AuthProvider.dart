// ignore_for_file: file_names

import 'package:gastrack/provider/Base_provider.dart';
import 'package:get/get.dart';

class LoginProvider extends BaseProvider {
  Future<Response> auth(var data) async {
    return post('$Url/login', data);
  }
}

class RegistrasiProvider extends BaseProvider {
  Future<Response> attempt(var data) async {
    return post('$Url/register', data);
  }
}

class LogoutProvider extends BaseProvider {
  Future<Response> logout(var token) async {
    return post('$Url/logout', token, headers: header);
  }
}
