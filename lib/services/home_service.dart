import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../rest/home_rest.dart';

class HomeService with ChangeNotifier {
  final HomeRest _api = HomeRest();

  final record = Record();

  bool isRecording = false;

  String? pathRecord = '';

  Timer? timer;
  Timer? ampTimer;
  int recordDuration = 0;
  Amplitude? amplitude;

  HomeService();

  recordAudio() async {
    pathRecord = '';
    if (await record.hasPermission()) {
      final tempDir = await getTemporaryDirectory();
      pathRecord =
          '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch.toString()}.m4a';

      await record.start(
        path: pathRecord,
      );
      isRecording = await record.isRecording();
      isRecording = isRecording;
      recordDuration = 0;
      _startTimer();
    }
  }

  stopRecord(BuildContext context) async {
    timer?.cancel();
    ampTimer?.cancel();
    isRecording = false;
    pathRecord = await record.stop();
    notifyListeners();
    _sendRecord(context, pathRecord!);

    ///test audio record
    /*
     final AudioPlayer _audioPlayer = AudioPlayer();
    File fileRecord = File(pathRecord!);
    if (fileRecord.existsSync()) {
      debugPrint(fileRecord.toString());
      await _audioPlayer.play(fileRecord.path, isLocal: true);
    }*/
  }

  void _startTimer() {
    timer?.cancel();
    ampTimer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      recordDuration++;
      notifyListeners();
    });

    ampTimer =
        Timer.periodic(const Duration(milliseconds: 200), (Timer t) async {
      amplitude = await record.getAmplitude();
      notifyListeners();
    });
  }

  _sendRecord(BuildContext context, String path) async {
    EasyLoading.show();
    await _api.sendRecord(context, path).then((dynamic lstResponse) async {
      if (lstResponse != null) {}
    }).catchError((Object error) {
      debugPrint(error.toString());
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: 'Hubó un error al enviar el activo fijo.',
        title: 'Error',
        confirmBtnText: 'Cerrar',
        backgroundColor: Colors.red[900] as Color,
      );
    });
    EasyLoading.dismiss();
  }
}
