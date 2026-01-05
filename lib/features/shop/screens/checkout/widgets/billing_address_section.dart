import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/personalization/controllers/address_controller.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UBillingAddressSection extends StatelessWidget {
  const UBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    controller.getAllAddresses();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// [Text] - Billing Address
        USectionHeading(title: 'Billing Address', buttonTitle: 'Change', onPressed: () => controller.selectNewAddressBottomSheet(context)),
        
        Obx(() {
          final address = controller.selectedAddress.value;
          if(address.id.isEmpty) {
            return Text('Select Address');
          }



          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address.name, style: Theme.of(context).textTheme.titleLarge),

              SizedBox(height: USizes.spaceBtwItems / 2),

              Row(
                children: [
                  Icon(Icons.phone, size: USizes.iconSm, color: UColors.darkGrey),
                  SizedBox(width:USizes.spaceBtwItems),
                  Text('+91 ${address.phoneNumber}', style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),

              SizedBox(height: USizes.spaceBtwItems / 2),

              Row(
                children: [
                  Icon(Icons.location_history, size: USizes.iconSm, color: UColors.darkGrey),
                  SizedBox(width:USizes.spaceBtwItems),
                  Expanded(child: Text(address.toString(), softWrap: true)),
                ],
              ),

            ],
          );
        })

      ],
    );
  }
}
