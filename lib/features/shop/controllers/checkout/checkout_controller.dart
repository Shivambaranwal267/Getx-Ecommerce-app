import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/models/payment_method_model.dart';
import 'package:ecommerce/features/shop/screens/checkout/widgets/payment_tile.dart';

import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CheckoutController  extends GetxController{
  static CheckoutController get instance => Get.find();

  /// Variables
  Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(name: 'Cash on delivery', image: UImages.codIcon);
    super.onInit();
  }

  Future<void> selectPaymentMethod(BuildContext context)  {
    return showModalBottomSheet(context: context, builder: (context) => SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(USizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            USectionHeading(title: 'Select Payment Method', showActionButton: false),
            SizedBox(height: USizes.spaceBtwSections),
            UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Cash on delivery', image: UImages.codIcon)),
            SizedBox(height: USizes.spaceBtwItems / 2),
            UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paypal', image: UImages.paypal)),
            SizedBox(height: USizes.spaceBtwItems / 2),
            UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Credit Card', image: UImages.creditCard)),
            SizedBox(height: USizes.spaceBtwItems / 2),
            UPaymentTile(paymentMethod: PaymentMethodModel(name: 'Master Card', image: UImages.masterCard)),
            SizedBox(height: USizes.spaceBtwItems / 2),
          ],
        ),
      ),
    ));
  }

}



