import 'package:get/get.dart';
import 'package:news_app_trpl_c/views/home_view.dart';
import 'package:news_app_trpl_c/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(name: Routes.SPLASH, page: () => SplashView()),
    GetPage(name: Routes.HOME, page: () => HomeView()),
  ];
}
