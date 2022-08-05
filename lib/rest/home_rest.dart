import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../utils/network_util.dart';
import '../utils/var.dart';

class HomeRest {
  final NetworkUtil _netUtil = NetworkUtil();

  Future<dynamic> sendRecord(BuildContext context, String path) async {
    final uri = Uri.https(Var.urlService, '');

    var formData = FormData.fromMap({
      'audio': await MultipartFile.fromFile(path, filename: 'audio.m4a'),
    });

    debugPrint(uri.toString());

    return _netUtil.multipart(context: context, url: uri, formData: formData);
  }
}
