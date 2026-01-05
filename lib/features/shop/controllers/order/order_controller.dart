import 'package:ecommerce/common/widgets/screens/success_screen.dart';
import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/data/repositories/order/order_repository.dart';
import 'package:ecommerce/features/personalization/controllers/address_controller.dart';
import 'package:ecommerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:ecommerce/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:ecommerce/features/shop/models/order_model.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/snackbar_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{
  static OrderController get instance => Get.find();


  /// Variables
  final cartController = CartController.instance;
  final checkoutController = CheckoutController.instance;
  final addressController = AddressController.instance;

  final _repository = Get.put(OrderRepository());

  ///
  Future<void> processOrder(double totalAmount) async {
    try {
      // Start Loading
      UFullScreenLoader.openLoadingDialog('Processing your order...');

      // Check User Existence
      String usedId = AuthenticationRepository.instance.currentUser!.uid;
      if(usedId.isEmpty) return;

      // Create Order Model
      OrderModel order = OrderModel(
          id: UniqueKey().toString(),
          status: OrderStatus.pending,
          items: cartController.cartItems.toList(),
          totalAmount: totalAmount,
          orderDate: DateTime.now(),
        userId: usedId,
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now()
      );

      // save order
      await _repository.saveOrder(order);

      // update cart
      cartController.clearCart();

      // show success screen
      Get.to(() => SuccessScreen(
          title: 'Payment Success',
          subTitle: 'Your item will be shipped soon',
          image: UImages.successfulPaymentIcon,
          onTap: () => Get.offAll(() => NavigationMenu())));

    } catch(e) {
      USnackBarHelpers.errorSnackBar(title: 'Order Failed!', message: e.toString());
    }
  }

  ///
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final orders = _repository.fetchUserOrders();
      return orders;
    } catch(e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
      return [];
    }

  }



}