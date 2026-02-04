import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:news_app_trpl_c/utils/app_colors.dart';


class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shadowColor: AppColors.cardShadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Shimmer.fromColors(
        baseColor: AppColors.divider,
        highlightColor: AppColors.divider.withValues(alpha: 0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image skeleton
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Source & Date
                  Row(
                    children: [
                      Expanded(child: _box(height: 12, width: 80)),
                      const SizedBox(width: 8),
                      _box(height: 12, width: 50),
                    ],
                  ),


                  const SizedBox(height: 12),


                  // Title (3 lines)
                  _box(height: 16),
                  const SizedBox(height: 6),
                  _box(height: 16),
                  const SizedBox(height: 6),
                  _box(height: 16, width: 180),


                  const SizedBox(height: 12),


                  // Description (2 lines)
                  _box(height: 14),
                  const SizedBox(height: 6),
                  _box(height: 14, width: 220),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  static Widget _box({required double height, double? width}) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}




