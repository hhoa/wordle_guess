import 'dart:io';

import 'package:get/get_connect.dart';

import 'base_url.dart';

class ApiBaseService extends GetConnect {
  ApiBaseService(this.servicePath);

  final String servicePath;

  String _getFullApiUrl(String path) =>
      'https://${ApiBaseUrl.host}$servicePath$path';

  Future<Response> callGet(String path) async {
    try {
      return await get(
        _getFullApiUrl(path),
      );
    } on SocketException {
      throw Exception('Network error');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
