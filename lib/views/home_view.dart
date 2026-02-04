// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_trpl_c/controllers/news_controller.dart';
import 'package:news_app_trpl_c/widgets/category_chip.dart';
import 'package:news_app_trpl_c/widgets/news_card.dart';
import 'package:news_app_trpl_c/widgets/loading_shimmer.dart';

class HomeView extends GetView<NewsController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'All',
      'Business',
      'Entertainment',
      'General',
      'Health',
      'Science',
      'Sports',
      'Technology',
    ];

    final RxString selectedCategory = 'All'.obs;

    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        centerTitle: true,
        actions: [
          IconButton(
          onPressed: () {
              _showSearchDialog(context);
            },
            icon: Icon(Icons.search)
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                final category = controller.categories[index];
                return Obx(
                  () => CategoryChip(
                    label: category.capitalize ?? 'No_Category',
                    isSelected: controller.selectCategory == category,
                    onTap: () {
                      print('Selected Category: $category');
                      controller.selectedCategory(category);
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: 5,
                  itemBuilder: (context, index) => const LoadingShimmer(),
                );
              }
              if (controller.error.isNotEmpty) {
                return Center(child: Text('Error: ${controller.error}'));
              }
              if (controller.articles.isEmpty) {
                return Center(child: Text('No articles available. ${controller.error}'));
              }
              return RefreshIndicator(
                onRefresh: () async {
                  controller.refreshNews();
                },
                child: ListView.builder(
                  itemCount: controller.articles.length,
                  itemBuilder: (context, index) {
                  final article = controller.articles[index];
                  return NewsCard(
                    article: article,
                    onTap: () {
                      Get.toNamed('/news-detail', arguments: article);
                    },
                  );
                },
                            ),
              );
            }),
          ),
        ],
      ),
    );
  }
  
  void _showSearchDialog(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Search News'),
            content: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Enter search term...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  controller.searchNews(value);
                  Navigator.of(context).pop();
                }
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (searchController.text.isNotEmpty) {
                    controller.searchNews(searchController.text);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Search'),
              ),
            ],
          ),
    );
  }
}
