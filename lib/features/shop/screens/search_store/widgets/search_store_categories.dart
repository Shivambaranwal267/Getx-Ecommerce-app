import 'package:ecommerce/common/widgets/images/rounded_images.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchStoreCategories extends StatelessWidget {
  const SearchStoreCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return Obx(() {
      /// Loading
      if (controller.isCategoriesLoading.value) return Center(child: CircularProgressIndicator());

      /// If Empty data
      if (controller.allCategories.isEmpty) return Text('No Categories Found!');

      /// If Data Found
      List<CategoryModel> categories = controller.allCategories.toList();
      return Column(
        children: [
          USectionHeading(title: 'Categories', showActionButton: false),

          const SizedBox(height: USizes.spaceBtwSections),

          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              CategoryModel category = categories[index];

              return ListTile(
                onTap: () => Get.to(
                        () => AllProductsScreen(
                            title: category.name,
                            futureMethod: controller.getCategoryProducts(categoryId: category.id)
                        )
                ),
                contentPadding: EdgeInsets.zero,
                leading: URoundedImage(
                  width: USizes.iconLg,
                  height: USizes.iconLg,
                  imageUrl: category.image,
                  borderRadius: 0,
                ),
                title: Text(category.name),
              );
            },
          ),
        ],
      );
    });
  }
}
