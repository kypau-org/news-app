// ignore_for_file: unused_field, unnecessary_overrides, avoid_print, non_constant_identifier_names

import 'package:get/get.dart';
import 'package:news_app_trpl_c/models/news_article.dart';
import 'package:news_app_trpl_c/services/news_service.dart';
import 'package:news_app_trpl_c/utils/constants.dart';

class NewsController extends GetxController {
  final NewsService _newsService = NewsService();

  // OBS Variables
  final _isLoading = true.obs;
  final _articles = <NewsArticle>[].obs;
  final _selectCategory = 'general'.obs;
  final _error = ''.obs;

  // Getters
  bool get isLoading => _isLoading.value;
  List<NewsArticle> get articles => _articles;
  String get selectCategory => _selectCategory.value;
  String get error => _error.value;
  List<String> get categories => Constants.categories;

  @override
  void onInit() {
    super.onInit();
    fetchTopHeadlines();
  }

  Future<void> fetchTopHeadlines({String? category}) async {
    try {
      _isLoading.value = true;
      _error.value = '';
      final response = await _newsService.getToHeadlines(
        category: category ?? _selectCategory.value,
      );
      _articles.value = response.articles;
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      _isLoading.value = false;
    }
  }

  void refreshNews() async {
    await fetchTopHeadlines(category: _selectCategory.value);
  }

  void selectedCategory(String category) {
    _selectCategory.value = category;
    fetchTopHeadlines(category: category);
  }

   Future<void> searchNews(String query) async {
    if (query.isEmpty) return;

    try {
      _isLoading.value = true;
      _error.value = '';

      final response = await _newsService.searchNews(query: query);
      _articles.value = response.articles;
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to search news: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }
}