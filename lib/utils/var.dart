import 'package:flutter/material.dart';

import 'custom_colors.dart';

class Var {
  static String urlService = 'qoonmmnp91.execute-api.us-east-1.amazonaws.com';

  static ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: CustomColors.dartMainColor,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );
}
