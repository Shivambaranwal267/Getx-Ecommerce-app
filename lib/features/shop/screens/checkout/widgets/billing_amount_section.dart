import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UBillingAmountSection extends StatelessWidget {
  const UBillingAmountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Amount
        Column(
          children: [

            Row(
              children: [
                Expanded(child: Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium)),
                Text('\$343', style: Theme.of(context).textTheme.labelLarge)
              ],
            ),

            SizedBox(height: USizes.spaceBtwItems / 2),

            // Shipping Fee
            Row(
              children: [
                Expanded(child: Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium)),
                Text('\$34', style: Theme.of(context).textTheme.labelLarge)
              ],
            ),
            SizedBox(height: USizes.spaceBtwItems / 2),

            // Tax fee
            Row(
              children: [
                Expanded(child: Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium)),
                Text('\$3', style: Theme.of(context).textTheme.labelLarge)
              ],
            ),

            SizedBox(height: USizes.spaceBtwItems / 2),

            // Order Total
            Row(
              children: [
                Expanded(child: Text('Order Total', style: Theme.of(context).textTheme.bodyMedium)),
                Text('\$3726', style: Theme.of(context).textTheme.titleMedium)
              ],
            ),


          ],
        ),

      ],
    );
  }
}
