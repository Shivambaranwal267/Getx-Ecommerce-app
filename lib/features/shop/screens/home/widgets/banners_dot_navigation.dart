import 'package:ecommerce/features/shop/controllers/banner/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannersDotNavigation extends StatelessWidget {
  const BannersDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(BannerController());

    return Obx(
      () => SmoothPageIndicator(
        count: controller.banners.length,
        effect: ExpandingDotsEffect(dotHeight: 6.0),
        controller: PageController(initialPage: controller.currentIndex.value),
      ),
    );
  }
}
