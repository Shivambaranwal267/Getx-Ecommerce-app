import 'package:ecommerce/common/widgets/products/cart/cart_item.dart';
import 'package:ecommerce/common/widgets/products/cart/product_quantity_with_add_remove.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UCartItems extends StatelessWidget {
  const UCartItems({super.key,  this.showAddRemoveButtons = true});

   final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => SizedBox(height: USizes.spaceBtwSections),
        itemCount: controller.cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = controller.cartItems[index];
          return Column(
            children: [

              /// Cart Item
              UCartItem(cartItem: cartItem),
              if(showAddRemoveButtons) SizedBox(height: USizes.spaceBtwItems),

              /// Price,counter button
              if(showAddRemoveButtons) Row(
                children: [

                  /// Extra Space
                  SizedBox(width: 70.0),

                  /// Quantity Buttons
                  UProductQuantityWithAddRemove(
                    quantity: cartItem.quantity,
                    add: () => controller.addOneToCart(cartItem),
                    remove: () => controller.removeOneFromCart(cartItem),
                  ),

                  const Spacer(),

                  /// Product Price
                  UProductPriceText(price: (cartItem.price * cartItem.quantity).toStringAsFixed(0)),

                ],
              )
            ],
          );

        },
      ),
    );
  }
}