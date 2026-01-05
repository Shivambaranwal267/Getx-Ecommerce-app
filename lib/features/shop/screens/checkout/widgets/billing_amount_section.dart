import 'package:ecommerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

class UBillingAmountSection extends StatelessWidget {
  const UBillingAmountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;

    return Column(
      children: [
        // Amount
        Column(
          children: [

            // Subtotal
            Row(
              children: [
                Expanded(child: Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium)),
                Text('\$${UTexts.currency}$subTotal', style: Theme.of(context).textTheme.labelLarge)
              ],
            ),

            SizedBox(height: USizes.spaceBtwItems / 2),

            // Shipping Fee
            Row(
              children: [
                Expanded(child: Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium)),
                Text('\$${UTexts.currency}${UPricingCalculator.calculateShippingCost(subTotal, 'India')}', style: Theme.of(context).textTheme.labelLarge)
              ],
            ),
            SizedBox(height: USizes.spaceBtwItems / 2),

            // Tax fee
            Row(
              children: [
                Expanded(child: Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium)),
                Text('\$${UTexts.currency}${UPricingCalculator.calculateTax(subTotal, 'India')}', style: Theme.of(context).textTheme.labelLarge)
              ],
            ),

            SizedBox(height: USizes.spaceBtwItems / 2),

            // Order Total
            Row(
              children: [
                Expanded(child: Text('Order Total', style: Theme.of(context).textTheme.bodyMedium)),
                Text('\$${UTexts.currency}${UPricingCalculator.calculateTotalPrice(subTotal, 'India')}', style: Theme.of(context).textTheme.titleMedium)
              ],
            ),


          ],
        ),

      ],
    );
  }
}
