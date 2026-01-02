import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:ecommerce/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';

import 'package:ecommerce/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return Scaffold(

      ///---------APPBAR-------------
      appBar: UAppBar(showBackArrow: true, title: Text(category.name, style: Theme.of(context).textTheme.headlineSmall)),

      ///---------BODY-------------
      body: SingleChildScrollView(
        padding: UPadding.screenPadding,
        child: Column(
          children: [

            /// Fetch Sub-Category for categories
            FutureBuilder(
              future: controller.getSubCategories(category.id),
              builder: (context, snapshot) {

                /// Handle Loader, Error & Empty
                const loader = UHorizontalProductShimmer();
                final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                if (widget != null) return widget;

                /// If Data Found - SubCategories found
                final subCategories = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: subCategories.length,
                  itemBuilder: (context, index) {

                    final subCategory = subCategories[index];

                    /// Fetch Products for Sub Category
                    return FutureBuilder(
                      future: controller.getCategoryProducts(categoryId: subCategory.id),
                      builder: (context, snapshot) {

                        /// Handle Error. Loading & Empty data
                        const loader = UHorizontalProductShimmer();
                        final widget = UCloudHelperFunctions.checkMultiRecordState(
                          snapshot: snapshot,
                          loader: loader,
                        );
                        if (widget != null) return widget;

                        /// If Data Found = Product Found
                        List<ProductModel> products = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// Sub Category Title
                            USectionHeading(
                              title: subCategory.name,
                              onPressed: () => Get.to(
                                    () => AllProductsScreen(
                                  title: subCategory.name,
                                  futureMethod: controller.getCategoryProducts(
                                    categoryId: subCategory.id,
                                    limit: -1,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: USizes.spaceBtwItems / 2),

                            /// Horizontal Products
                            SizedBox(
                              height: 120,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: products.length,
                                separatorBuilder: (_, __) =>
                                const SizedBox(width: USizes.spaceBtwItems / 2),
                                itemBuilder: (context, index) =>
                                    UProductCardHorizontal(product: products[index]),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),

    );
  }
}
