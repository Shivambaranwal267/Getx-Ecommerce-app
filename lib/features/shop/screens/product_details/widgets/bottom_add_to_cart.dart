import 'package:ecommerce/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UBottomAddToCart extends StatelessWidget {
  const UBottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunctions.isDarkMode(context);
    final controller = CartController.instance;

    controller.updateAlreadyAddedProductCount(product);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: USizes.defaultSpace,
        vertical: USizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? UColors.darkGrey : UColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(USizes.cardRadiusLg),
          topRight: Radius.circular(USizes.cardRadiusLg),
        ),
      ),
      child: Obx(
        () => Row(
          children: [

            /// Decrement button
            UCircularIcon(
              icon: Iconsax.minus,
              backgroundColor: UColors.darkGrey,
              width: 40,
              height: 40,
              color: UColors.white,
              onPressed: controller.productQuantityInCart.value < 1 ? null : () => controller.productQuantityInCart.value -= 1,
            ),
            SizedBox(width: USizes.spaceBtwItems),

            /// Counter
            Text(controller.productQuantityInCart.value.toString(), style: Theme.of(context).textTheme.titleSmall),
            SizedBox(width: USizes.spaceBtwItems),

            /// Increment button
            UCircularIcon(
              icon: Iconsax.add,
              backgroundColor: UColors.black,
              width: 40,
              height: 40,
              color: UColors.white,
              onPressed: () => controller.productQuantityInCart.value += 1,
            ),

            const Spacer(),

            /// Add to Cart Button
            ElevatedButton(
              onPressed: controller.productQuantityInCart.value < 1 ? null :
                         () => controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(USizes.md),
                backgroundColor: UColors.black,
                side: BorderSide(color: UColors.black),
              ),
              child: Row(
                children: [
                  Icon(Iconsax.shopping_bag),
                  SizedBox(width: USizes.spaceBtwItems / 2),
                  Text('Add To Cart'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
