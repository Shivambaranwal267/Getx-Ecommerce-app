import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/button/elevated_button.dart';
import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:ecommerce/common/widgets/screens/success_screen.dart';
import 'package:ecommerce/common/widgets/textfields/promo_code.dart';
import 'package:ecommerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:ecommerce/features/shop/controllers/order/order_controller.dart';
import 'package:ecommerce/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ecommerce/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/helpers/pricing_calculator.dart';
import 'package:ecommerce/utils/popups/snackbar_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/billing_address_section.dart';
import 'widgets/billing_amount_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    double subTotal = controller.totalCartPrice.value;
    double totalPrice = UPricingCalculator.calculateTotalPrice(subTotal, 'India');
    final orderController = Get.put(OrderController());

    return Scaffold(
      ///-----------[APPBAR]--------------///
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      ///-----------[BODY]-----------------///
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              /// Items
              UCartItems(showAddRemoveButtons: false),
              SizedBox(height: USizes.spaceBtwSections),

              /// PROMO CODE - TextField
              UPromoCodeField(),
              SizedBox(height: USizes.spaceBtwSections),
              
              /// Billing Section
              URoundedContainer(
                showBorder: true,
                padding: EdgeInsets.all(USizes.md),
                backgroundColor: Colors.transparent,
                child:

                Column(
                  children: [
                    /// Amount
                    UBillingAmountSection(),
                    SizedBox(height: USizes.spaceBtwItems),

                    /// payment section
                    UBillingPaymentSection(),
                    SizedBox(height: USizes.spaceBtwItems),

                    /// Address
                    UBillingAddressSection()
                  ],
                )
              )
              
            ],
          ),
        ),
      ),

      ///-----------[BottomNavigation]--------------///
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(USizes.defaultSpace),
        child: UElevatedButton(
            onPressed: subTotal > 0
                ? () => orderController.processOrder(totalPrice)
                : () => USnackBarHelpers.errorSnackBar(title: 'Empty Cart', message: 'Add items in the cart'),
            child: Text('Checkout ${UTexts.currency}$totalPrice')
        ),
      ),

    );
  }
}



