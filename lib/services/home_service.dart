import 'dart:async';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';
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
      var status = await Permission.storage.status;
      if (status.isDenied) {
        await Permission.storage.request();
      }

      final tempPath = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);

      String path = await createFolderInAppDocDir('Bimbo delivery', tempPath);

      pathRecord =
          '$path${DateTime.now().millisecondsSinceEpoch.toString()}.wav';

      await record.start(
        path: pathRecord,
      );
      isRecording = await record.isRecording();
      isRecording = isRecording;
      recordDuration = 0;
      _startTimer();
    }
  }

  static Future<String> createFolderInAppDocDir(
      String folderName, String path) async {
    final Directory _appDocDirFolder = Directory('$path/$folderName/');

    if (await _appDocDirFolder.exists()) {
      return _appDocDirFolder.path;
    } else {
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

  stopRecord(BuildContext context) async {
    timer?.cancel();
    ampTimer?.cancel();
    isRecording = false;
    pathRecord = await record.stop();
    File fileRecord = File(pathRecord!);
    if (fileRecord.existsSync()) {
      await _sendRecord(context, fileRecord);
    }

    notifyListeners();

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

  _sendRecord(BuildContext context, File file) async {
    EasyLoading.show();
    await _api.sendRecord(context, file).then((dynamic lstResponse) async {
      if (lstResponse != null) {
        debugPrint(lstResponse);
      }
    }).catchError((Object error) {
      debugPrint(error.toString());
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: 'Hubó un error al enviar el audio.',
        title: 'Error',
        confirmBtnText: 'Cerrar',
        backgroundColor: Colors.red[900] as Color,
      );
    });
    EasyLoading.dismiss();
  }
}
