import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/common/widgets/images/rounded_images.dart';
import 'package:ecommerce/common/widgets/shimmer/shimmer_effect.dart';
import 'package:ecommerce/features/shop/controllers/banner/banner_controller.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/banners_dot_navigation.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UPromoSlider extends StatelessWidget {
  // const UPromoSlider({super.key, required this.banners});
  const UPromoSlider({super.key});

  // final List<String> banners;

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(BannerController());

    return Obx(
        () {

          // [Loading State]
          if(controller.isLoading.value) {
            return UShimmerEffect(width: double.infinity, height: 190);
          }

          if(controller.banners.isEmpty) {
            return Text('Banner Not Found');
          }

          return Column(
            children: [
              // Slider
              CarouselSlider(
                items: controller.banners.map((banner) =>
                    URoundedImage(imageUrl: banner.imageUrl, isNetworkImage: true,onTap: () => Get.toNamed(banner.targetScreen))).toList(),
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) => controller.onPageChanged(index),
                  // autoPlay: true,
                  enlargeCenterPage: true
                ),
                carouselController: controller.carouselController,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              BannersDotNavigation(),
            ],
          );
        }
    );
  }
}
