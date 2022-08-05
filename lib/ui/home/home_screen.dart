import 'package:flutter/material.dart';
import 'package:loading/indicator.dart';
import 'package:loading/indicator/line_scale_indicator.dart';
import 'package:loading/indicator/line_scale_pulse_out_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

import '../../services/home_service.dart';
import '../../utils/custom_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeService homeService;

  @override
  void dispose() {
    homeService.timer?.cancel();
    homeService.ampTimer?.cancel();
    homeService.record.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    homeService = Provider.of<HomeService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bimbo reparto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Presione el botón para grabar el pedido'),
            const SizedBox(height: 20),
            homeService.isRecording ? _equalizer() : _staticEqualizer(),
            _buildRecordStopControl(),
            const SizedBox(height: 20),
            homeService.isRecording ? _buildTimer() : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordStopControl() {
    late Icon icon;
    late Color color;
    if (homeService.isRecording) {
      icon = const Icon(Icons.stop, color: CustomColors.mainColor, size: 30);
      color = CustomColors.mainColor.withOpacity(0.1);
    } else {
      icon = const Icon(Icons.mic, color: CustomColors.mainColor, size: 30);
      color = CustomColors.mainColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            homeService.isRecording
                ? homeService.stopRecord(context)
                : homeService.recordAudio();
          },
        ),
      ),
    );
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(homeService.recordDuration ~/ 60);
    final String seconds = _formatNumber(homeService.recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: const TextStyle(color: CustomColors.mainColor),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  Widget _staticEqualizer() {
    List<Widget> lstDecoration = [];
    for (int i = 0; i <= 19; i++) {
      lstDecoration.add(
        Container(
          height: i.isOdd ? 40 : 30,
          width: 6,
          margin: EdgeInsets.only(right: 5, left: i % 5 == 0 ? 5 : 0),
          decoration: const BoxDecoration(
              color: CustomColors.mainColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
        ),
      );
    }
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: lstDecoration,
          ),
        ),
      ],
    );
  }

  Widget _equalizer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _customIndicator(LineScalePulseOutIndicator()),
        _customIndicator(LineScaleIndicator()),
        _customIndicator(LineScalePulseOutIndicator()),
        _customIndicator(LineScaleIndicator()),
      ],
    );
  }

  Widget _customIndicator(Indicator indicator) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 55,
      child: Loading(
        indicator: indicator,
        size: 60,
        color: theme.primaryColor,
      ),
    );
  }
}
