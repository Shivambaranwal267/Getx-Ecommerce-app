import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:ecommerce/features/shop/models/payment_method_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UBillingPaymentSection extends StatelessWidget {
  const UBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark  = UHelperFunctions.isDarkMode(context);
    final controller = Get.put(CheckoutController());

    return Column(
      children: [
        USectionHeading(title: 'Payment Method', buttonTitle: 'Change', onPressed: () => controller.selectPaymentMethod(context)),

        SizedBox(height: USizes.spaceBtwItems / 2),
        
        Obx(
          () => Row(
            children: [

              // Payment Logo
              URoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? UColors.light : UColors.white,
                padding: EdgeInsets.all(USizes.sm),
                child: Image(image: AssetImage(controller.selectedPaymentMethod.value.image), fit: BoxFit.contain),
              ),

              SizedBox(width: USizes.spaceBtwItems / 2),

              // Payment Name
              Text(controller.selectedPaymentMethod.value.name, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        )

      ],
    );
  }
}
