import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'services/home_service.dart';
import 'services/login_service.dart';
import 'utils/custom_colors.dart';
import 'utils/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeService()),
        ChangeNotifierProvider(create: (_) => LoginService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bimbo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: CustomColors.colorCustom,
          primaryColor: CustomColors.mainColor,
          brightness: Brightness.light,
          appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              color: CustomColors.mainColor),
        ),
        builder: EasyLoading.init(),
        initialRoute: '/',
        routes: routes,
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        supportedLocales: const [Locale('es'), Locale('en')],
      ),
    );
  }
}
