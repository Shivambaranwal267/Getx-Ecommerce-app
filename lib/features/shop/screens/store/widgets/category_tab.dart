import 'package:ecommerce/common/widgets/brands/brand_showcase.dart';
import 'package:ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerce/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerce/features/shop/screens/store/widgets/category_brands.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UCategoryTab extends StatelessWidget {
  const UCategoryTab({
    super.key, required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
          child: Column(
            children: [

             CategoryBrands(category: category),

              SizedBox(height: USizes.spaceBtwItems),

              /// you might like section heading
              USectionHeading(title: 'You might like', onPressed: () => Get.to(() => AllProductsScreen(
                  title: category.name,
                  futureMethod: controller.getCategoryProducts(categoryId: category.id, limit: -1),
              ))),

              /// Grid Layout Products
              FutureBuilder(
                  future: controller.getCategoryProducts(categoryId: category.id, limit: -1),
                  builder: (context, snapshot) {

                    /// Handle Error, Loader and Empty States
                    const loader = UVerticalProductShimmer(itemCount: 4);
                    final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                    if(widget != null) return widget;

                    /// If Data Found
                    List<ProductModel> products = snapshot.data!;
                    return UGridLayout(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          ProductModel product = products[index];
                           return UProductCardVertical(
                              product: product,
                          );
                        });

                  },
              ),

              SizedBox(height: USizes.spaceBtwSections)
            ],

          ),
        ),
      ],
    );
  }
}