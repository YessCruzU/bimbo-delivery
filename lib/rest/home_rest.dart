import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:http_parser/http_parser.dart';

import '../utils/network_util.dart';
import '../utils/var.dart';

class HomeRest {
  final NetworkUtil _netUtil = NetworkUtil();

  Future<dynamic> sendRecord(BuildContext context, File file) async {
    final uri = Uri.https(Var.urlService, '/playground/process_audio');

    Map<String, String>? headers = {'Content-Type': 'multipart/form-data'};

    var formData = FormData.fromMap({
      'file': MultipartFile.fromFileSync(file.path,
          filename: file.name, contentType: MediaType('audio', 'wav')),
    });

    debugPrint(uri.toString());

    return _netUtil.multipart(
        context: context, url: uri, formData: formData, headers: headers);
  }
}

extension FileExtention on FileSystemEntity {
  String get name {
    return path.split("/").last;
  }
}
