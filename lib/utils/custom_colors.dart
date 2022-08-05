import 'package:flutter/material.dart';

class CustomColors {
  static const Color dartMainColor = Color(0xFF07101B);
  static const Color mainColor = Color(0xFF133155);

  static Map<int, Color> color = {
    50: const Color.fromRGBO(19, 49, 85, .1),
    100: const Color.fromRGBO(19, 49, 85, .2),
    200: const Color.fromRGBO(19, 49, 85, .3),
    300: const Color.fromRGBO(19, 49, 85, .4),
    400: const Color.fromRGBO(19, 49, 85, .5),
    500: const Color.fromRGBO(19, 49, 85, .6),
    600: const Color.fromRGBO(19, 49, 85, .7),
    700: const Color.fromRGBO(19, 49, 85, .8),
    800: const Color.fromRGBO(19, 49, 85, .9),
    900: const Color.fromRGBO(19, 49, 85, 1),
  };

  static MaterialColor colorCustom = MaterialColor(0xFF133155, color);
  static MaterialColor dartColorCustom = MaterialColor(0xFF07101B, color);
}
