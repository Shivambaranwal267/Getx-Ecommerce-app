import 'package:ecommerce/common/widgets/image_text/vertical_image_text.dart';
import 'package:ecommerce/common/widgets/shimmer/category_shimmer.dart';
import 'package:ecommerce/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/features/shop/screens/sub_category/sub_category.dart';
import 'package:ecommerce/utils/constants/colors.dart';

import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UHomeCategories extends StatelessWidget {
  const UHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Padding(
      padding: const EdgeInsets.only(left: USizes.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Section Heading
          Text(
            UTexts.popularCategories,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: UColors.light),
          ),

          SizedBox(height: USizes.spaceBtwItems),

          /// Category List
          Obx(
            () {

              final categories = controller.featuredCategories;

              // [loadingState]
              if(controller.isCategoriesLoading.value) {
                return UCategoryShimmer(itemCount: 8);
              }

              // empty
              if(categories.isEmpty) {return Text('Categories Not found');}

              // Data found
              return SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      SizedBox(width: USizes.spaceBtwItems),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    CategoryModel category = categories[index];
                    return UVerticalImageText(
                      title: category.name, image: category.image, textColor: UColors.white,onTap: () => Get.to(() => SubCategoryScreen(category: category)),
                    );
                  },
                ),
              );

            }
          ),
        ],
      ),
    );
  }
}
