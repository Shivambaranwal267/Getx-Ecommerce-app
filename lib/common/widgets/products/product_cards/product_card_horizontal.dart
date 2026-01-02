import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:ecommerce/common/widgets/images/rounded_images.dart';
import 'package:ecommerce/common/widgets/products/favourite/favourite_icon.dart';
import 'package:ecommerce/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/screens/product_details/product_details.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class UProductCardHorizontal extends StatelessWidget {
  const UProductCardHorizontal({
    super.key,
    required this.product
  });

  final ProductModel product;


  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    String? salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(product: product)),
      child: Container(
          width: 310,
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(USizes.productImageRadius),
            color : dark ? UColors.darkerGrey : UColors.light,
          ),
          child: Row(
            children: [

              /// Left Portion
              URoundedContainer(
                height: 120,
                padding: EdgeInsets.all(USizes.sm),
                backgroundColor: dark ? UColors.dark : UColors.light,
                child: Stack(
                  children: [

                    /// Thumbnail
                    SizedBox(
                        width: 120,
                        height: 120,
                        child: URoundedImage(imageUrl: product.thumbnail, isNetworkImage: true)),

                    /// Discount Tag
                    if(salePercentage != null)
                      Positioned(
                        top: 12.0,
                        child: URoundedContainer(
                          radius: USizes.sm,
                          backgroundColor: UColors.yellow.withValues(alpha: 0.8),
                          padding: const EdgeInsets.symmetric(horizontal: USizes.sm, vertical: USizes.xs),
                          child: Text('$salePercentage%', style: Theme.of(context).textTheme.labelLarge!.apply(color: UColors.black)),
                        ),
                      ),

                    /// Favourite Button
                    Positioned(right: 0, top: 0, child: UFavouriteIcon(productId: product.id))
                  ],
                ),
              ),

              /// Right Portion
              SizedBox(
                width: 172.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: USizes.sm, top: USizes.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Product Title
                          UProductTitleText(title: product.title, smallSize: true),
                          SizedBox(height: USizes.spaceBtwItems / 2),

                          /// Product Brand
                          UBrandTitleWithVerifyIcon(title: product.brand!.name)

                        ],
                      ),
                      Spacer(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          /// Product Price
                          Flexible(child: UProductPriceText(price: controller.getProductPrice(product))),

                          /// Add Button
                          // ProductAddToCartButton(product: product)
                          Container(
                            width: USizes.iconLg * 1.2,
                            height: USizes.iconLg * 1.2,
                            decoration: BoxDecoration(
                              color: UColors.primary,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(USizes.cardRadiusMd),
                                bottomRight: Radius.circular(USizes.productImageRadius),
                              ),
                            ),
                            child: Icon(Iconsax.add, color: UColors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}