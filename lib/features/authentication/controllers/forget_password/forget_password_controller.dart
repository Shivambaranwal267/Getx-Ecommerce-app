import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/features/authentication/screens/forget_password/reset_password.dart';
import 'package:ecommerce/utils/helpers/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/snackbar_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  final forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Email to Forget Password
  Future<void> sendPasswordResetEmail() async {
    try {
      // Start Loading
      UFullScreenLoader.openLoadingDialog('Processing your request...');

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // send mail to reset password
      AuthenticationRepository.instance.sendPasswordResetEmail(
        email.text.trim(),
      );

      // stop loading
      UFullScreenLoader.stopLoading();

      // Success Message
      USnackBarHelpers.successSnackBar(
        title: 'Email Sent!',
        message: 'Email link Sent to Reset your password.',
      );

      // Redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (err) {
      // stop loading
      UFullScreenLoader.stopLoading();

      // Error message
      USnackBarHelpers.errorSnackBar(
        title: "Failed Forget Password",
        message: err.toString(),
      );
    }
  }

  /// Send Email to Forget Password
  Future<void> resendPasswordResetEmail() async {
    try {
      // Start Loading
      UFullScreenLoader.openLoadingDialog('Processing your request...');

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      // send mail to reset password
      AuthenticationRepository.instance.sendPasswordResetEmail(
        email.text.trim(),
      );

      // stop loading
      UFullScreenLoader.stopLoading();

      // Success Message
      USnackBarHelpers.successSnackBar(
        title: 'Email Sent!',
        message: 'Email link Sent to Reset your password.',
      );
    } catch (err) {
      // stop loading
      UFullScreenLoader.stopLoading();

      // Error message
      USnackBarHelpers.errorSnackBar(
        title: "Failed Forget Password",
        message: err.toString(),
      );
    }
  }
}
