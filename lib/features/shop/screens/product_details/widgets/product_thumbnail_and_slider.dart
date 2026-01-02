import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce/common/widgets/images/rounded_images.dart';
import 'package:ecommerce/common/widgets/products/favourite/favourite_icon.dart';
import 'package:ecommerce/features/shop/controllers/product/image_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UProductThumbnailAndSlider extends StatelessWidget {
  const UProductThumbnailAndSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    final controller = Get.put(ImageController());

    List<String> images = controller.getAllProductImages(product);

    return Container(
      color: dark ? UColors.darkGrey : UColors.light,
      child: Stack(
        children: [
          // Image - [thumbnail]
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(USizes.productImageRadius * 2),
              child: Center(
                child: Obx(() {
                  final image = controller.selectedProductImage.value;
                  return GestureDetector(
                    onTap: () => controller.showEnlargeImage(image),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      progressIndicatorBuilder: (context, url, progress) =>
                          CircularProgressIndicator(
                            color: UColors.primary,
                            value: progress.progress,
                          ),
                    ),
                  );
                }),
              ),
            ),
          ),

          // Image Slider
          Positioned(
            left: USizes.defaultSpace,
            right: 0,
            bottom: 30,
            child: SizedBox(
              height: 80.0,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(width: USizes.spaceBtwItems),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) => Obx(() {
                  bool isImageSelected = controller.selectedProductImage.value == images[index];
                  return URoundedImage(
                    width: 80,
                    isNetworkImage: true,
                    onTap: () =>
                        controller.selectedProductImage.value = images[index],
                    backgroundColor: dark ? UColors.dark : UColors.white,
                    padding: EdgeInsets.all(USizes.md),
                    border: Border.all(color: isImageSelected ? UColors.primary : Colors.transparent),
                    imageUrl: images[index],
                  );
                }),
              ),
            ),
          ),

          /// [Appbar] - back arrow & favorite icon
          UAppBar(showBackArrow: true, actions: [UFavouriteIcon(productId: product.id)],
          ),
        ],
      ),
    );
  }
}
