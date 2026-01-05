import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/button/elevated_button.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'widgets/product_meta_data.dart';
import 'widgets/product_thumbnail_and_slider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-----------[BODY]-----------
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Product Image with slider
            UProductThumbnailAndSlider(product: product),

            Padding(
              padding: UPadding.screenPadding,
              child: Column(
                children: [
                  /// Product Details
                  /// Price,title,stock and Brands
                  UProductMetaData(product: product),
                  SizedBox(height: USizes.spaceBtwSections / 2),

                  /// Attribute
                  if(product.productType == ProductType.variable.toString())...[
                    UProductAttributes(product: product),
                    SizedBox(height: USizes.spaceBtwSections),
                  ],


                  /// Checkout Button
                  UElevatedButton(onPressed: () {}, child: Text('Checkout')),
                  SizedBox(height: USizes.spaceBtwSections),

                  /// Description
                  USectionHeading(title: 'Description', showActionButton: false),
                  SizedBox(height: USizes.spaceBtwItems),

                  ReadMoreText(
                     product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Less',
                    moreStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                    lessStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: USizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),

      /// ----------[BOTTOM NAVIGATION]----------
      bottomNavigationBar: UBottomAddToCart(product: product),
    );
  }
}
