import 'package:ecommerce/features/shop/controllers/product/variation_controller.dart';
import 'package:ecommerce/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class UBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
  }
}
