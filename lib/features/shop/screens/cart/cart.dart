import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/button/elevated_button.dart';
import 'package:ecommerce/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce/common/widgets/loaders/animation_loader.dart';
import 'package:ecommerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:ecommerce/features/shop/screens/checkout/checkout.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Scaffold(
      ///-----------[AppBAR]--------------
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineMedium),
        actions: [UCircularIcon(icon: Iconsax.box_remove, onPressed: () => controller.clearCart())],
      ),

      ///-----------[body]--------------
      body: Obx(() {
        final emptyWidget = UAnimationLoader(
          text: 'Cart is Empty',
          animation: UImages.cartEmptyAnimation,
          showActionButton: true,
          actionText: "Lets fill it",
          onActionPressed: Get.back,
        );

        // No data Found
        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        }

        return SingleChildScrollView(
          child: Padding(padding: UPadding.screenPadding, child: UCartItems()),
        );
      }),

      ///-----------[BottomNavigation]--------------
      bottomNavigationBar: Obx(() {
        if (controller.cartItems.isEmpty) return SizedBox();

        return Padding(
          padding: const EdgeInsets.all(USizes.defaultSpace),
          child: UElevatedButton(
            onPressed: () => Get.to(() => CheckoutScreen()),
            child: Text(
              'Checkout \$${controller.totalCartPrice.value.toStringAsFixed(2)}',
            ),
          ),
        );
      }),
    );
  }
}
