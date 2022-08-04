import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/home_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeService homeService = Provider.of<HomeService>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              const Text('Presione el botón para grabar pedido'),
              IconButton(
                onPressed: homeService.recordAudio(),
                icon: const Icon(
                  Icons.record_voice_over,
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
