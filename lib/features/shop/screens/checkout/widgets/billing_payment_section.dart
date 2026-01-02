import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class UBillingPaymentSection extends StatelessWidget {
  const UBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark  = UHelperFunctions.isDarkMode(context);

    return Column(
      children: [
        USectionHeading(title: 'Payment Method', buttonTitle: 'Change', onPressed: (){}),

        SizedBox(height: USizes.spaceBtwItems / 2),
        
        Row(
          children: [
            // Payment Logo
            URoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? UColors.light : UColors.white,
              padding: EdgeInsets.all(USizes.sm),
              child: Image(image: AssetImage(UImages.googlePay), fit: BoxFit.contain),
            ),

            SizedBox(width: USizes.spaceBtwItems / 2),

            // Payment Name
            Text('Google Pay', style: Theme.of(context).textTheme.bodyLarge),
          ],
        )

      ],
    );
  }
}
