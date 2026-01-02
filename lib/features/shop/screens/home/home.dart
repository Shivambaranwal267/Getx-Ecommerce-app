import 'package:ecommerce/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerce/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/common/widgets/textfields/search_bar.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/home/home_controller.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'widgets/home_appbar.dart';
import 'widgets/promo_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final productController = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///---------[UPPER PART]----------
            Stack(
              children: [

                /// Total height + 10
                Container(height: USizes.homePrimaryHeaderHeight + 10),

                /// PRIMARY HEADER CONTAINER
                UPrimaryHeaderContainer(
                  height: USizes.homePrimaryHeaderHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// Appbar
                      UHomeAppBar(),

                      SizedBox(height: USizes.spaceBtwSections),

                      /// Home Categories
                      UHomeCategories(),
                    ],
                  ),
                ),

                /// Search Bar
                USearchBar(),
              ],
            ),

            ///---------[LOWER PART]----------
            Padding(
              padding: const EdgeInsets.all(USizes.defaultSpace),
              child: Column(
                children: [
                  /// Banners
                  UPromoSlider(),

                  const SizedBox(height: USizes.spaceBtwSections),

                  /// Section Heading
                  USectionHeading(title: 'Popular Products', onPressed: () => Get.to(() => AllProductsScreen(
                      title: 'Popular Products',
                      futureMethod: productController.getAllFeaturedProduct(),
                  ))),
                  SizedBox(height: USizes.spaceBtwItems),

                  /// Grid View of Vertical Product Card
                  Obx(
                    (){
                      if(productController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if(productController.featuredProducts.isEmpty) {
                        return Center(child: Text('Products Not Found!'));
                      }

                      return UGridLayout(
                        itemCount: productController.featuredProducts.length,
                        itemBuilder: (context, index) {
                          ProductModel product = productController.featuredProducts[index];
                        return UProductCardVertical(product: product);
                        },
                      );
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


