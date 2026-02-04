import 'package:get/get.dart';
import 'package:news_app_trpl_c/controllers/news_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsController>(() => NewsController());
  }
}