import '../ui/home/home_screen.dart';
import '../ui/login/login.dart';
import '../ui/splash/splash_screen.dart';

class RoutePaths {
  RoutePaths._();

  static const splash = '/';
  static const home = '/home';
  static const login = '/login';
}

final routes = {
  RoutePaths.splash: (_) => const SplashScreen(),
  RoutePaths.login: (_) => const LoginScreen(),
  RoutePaths.home: (_) => const HomeScreen(),
};
