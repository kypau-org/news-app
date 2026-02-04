// ignore_for_file: constant_identifier_names, unused_field

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const HOME = _Paths.HOME;
  static const NewsDetail = '/news-detail';
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const HOME = '/home';
  static const NewsDetail = '/news-detail';
}
