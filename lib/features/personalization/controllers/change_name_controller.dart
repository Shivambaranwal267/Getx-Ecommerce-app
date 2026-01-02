import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/helpers/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/snackbar_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeNameController extends GetxController {
  static ChangeNameController get instance =>  Get.find();


  /// Variables
  final _userController = UserController.instance;
  final _userRepository = UserRepository.instance;

  final firstName = TextEditingController();
  final lastName = TextEditingController();

  final updateUserFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  void initializeNames() {
    firstName.text = _userController.user.value.firstName;
    lastName.text = _userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try{

      // Start Loading
      UFullScreenLoader.openLoadingDialog('We are Updating your information');

      // Check Internet connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      // Form validation
      if(!updateUserFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // Update UserName form FireStore

      Map<String, dynamic> map = {'firstName' : firstName.text, 'lastName' : lastName.text};
      await _userRepository.updateSingleField(map);
          /// -----------OR------------///
      // await _userRepository.updateSingleField({'firstName' : firstName.text, 'lastName' : lastName.text});

      // Update user from RX User

      _userController.user.value.firstName = firstName.text;
      _userController.user.value.lastName = lastName.text;

      // stop loading
      UFullScreenLoader.stopLoading();

      // Redirect Screen
      Get.offAll(() => NavigationMenu());

      // Success Message
      USnackBarHelpers.successSnackBar(title: 'Congratulations!', message: 'You name had been Updated Successfully.' );

    }catch(err) {
      // stop loading
      UFullScreenLoader.stopLoading();

      // error message
      USnackBarHelpers.errorSnackBar(title: "Update Name Failed!", message: err.toString());
    }

  }

}
