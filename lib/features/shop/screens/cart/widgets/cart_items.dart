import 'package:ecommerce/common/widgets/products/cart/cart_item.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UCartItems extends StatelessWidget {
  const UCartItems({
    super.key,  this.showAddRemoveButtons = true,
  });

   final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => SizedBox(height: USizes.spaceBtwSections),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Column(
          children: [
            UCartItem(),
            if(showAddRemoveButtons) SizedBox(height: USizes.spaceBtwItems),

            /// Price,counter button
            if(showAddRemoveButtons) Row(
              children: [
                /// Extra Space
                SizedBox(width: 70.0),

                // UProductQuantityWithAddRemove(),

                const Spacer(),

                UProductPriceText(price: '323'),
              ],
            )
          ],
        );
      },
    );
  }
}