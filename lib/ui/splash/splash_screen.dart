import 'package:flutter/material.dart';

import '../../utils/custom_colors.dart';
import '../../utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Navigator.of(context).pushReplacementNamed(RoutePaths.home);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/bimbo_car.jpg',
              alignment: Alignment.topCenter,
              fit: BoxFit.scaleDown,
              height: 128,
            ),
            const Text(
              'Bimbo delivery',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            const CircularProgressIndicator(
                backgroundColor: CustomColors.dartMainColor),
          ],
        ),
      ),
    );
  }
}
