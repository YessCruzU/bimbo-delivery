import 'dart:io';

import 'package:flutter/widgets.dart';

import '../utils/network_util.dart';
import '../utils/var.dart';

class HomeRest {
  final NetworkUtil _netUtil = NetworkUtil();

  Future<dynamic> sendRecord(BuildContext context, File file) async {
    final uri = Uri.https(Var.urlService, '/playground/process_audio');

    final Map<String, String>? headers = {'Content-Type': 'application/json'};
    final body = {'order': file.readAsBytesSync()};

    debugPrint(body.toString());

    return _netUtil.post(context, uri, body: body, headers: headers);
  }
}
