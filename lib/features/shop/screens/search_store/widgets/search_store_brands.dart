import 'package:ecommerce/common/widgets/image_text/vertical_image_text.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/brand/brand_controller.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:ecommerce/features/shop/screens/brands/all_brands.dart';
import 'package:ecommerce/features/shop/screens/brands/brand_products.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchStoreBrands extends StatelessWidget {
  const SearchStoreBrands({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    bool dark = UHelperFunctions.isDarkMode(context);

    return Obx(() {
      /// Loading
      if (controller.isLoading.value) return Center(child: CircularProgressIndicator());

      /// If Empty data
      if (controller.allBrands.isEmpty) return Text('No Brands Found!');

      /// If Data Found
      List<BrandModel> brands = controller.allBrands.take(10).toList();
      return Column(
        children: [
          USectionHeading(title: 'Brands', onPressed: () => Get.to(() => BrandScreen())),

          const SizedBox(height: USizes.spaceBtwItems),

          Wrap(
            spacing: USizes.spaceBtwItems,
            runSpacing: USizes.spaceBtwItems,
            children: brands
                .map(
                  (brand) => UVerticalImageText(
                    onTap: () => Get.to(() => BrandProductsScreen(title: brand.name, brand: brand)),
                    title: brand.name,
                    image: brand.image,
                    textColor: dark ? UColors.white : UColors.black,
                  ),
                ).toList(),
          ),
        ],
      );
    });
  }
}
