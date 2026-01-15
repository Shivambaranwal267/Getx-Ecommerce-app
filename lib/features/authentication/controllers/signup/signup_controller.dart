import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:ecommerce/features/authentication/screens/signup/verify_email.dart';
import 'package:ecommerce/utils/helpers/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/snackbar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  /// Variables
  final signUpFormKey = GlobalKey<FormState>();
  RxBool isPasswordVisible = false.obs;
  RxBool privacyPolicy = false.obs;

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  /// Function to register the user with email & password
  Future<void> registerUser() async {
    try {

      // Start Loading
      UFullScreenLoader.openLoadingDialog('We are processing your information...');

      // Check Internet connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      // Form Validation
      if (!signUpFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // Check Privacy policy
      if (!privacyPolicy.value) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'In Order to create account, you must have to read and accept the Privacy Policy & Terms of Use.',
        );
        return;
      }

      // Register the User using firebase authentication
      UserCredential userCredential = await AuthenticationRepository.instance.registerUser(email.text.trim(), password.text.trim());

      // create user model
      UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text,
        lastName: lastName.text,
        username: '${firstName.text}${lastName.text}716283',
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      // save user record
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(userModel);

      // success message
      USnackBarHelpers.successSnackBar(title: 'Congratulations!', message: 'Your account has been created! Verify email to continue.');

      // loading stop
      UFullScreenLoader.stopLoading();

      // redirect to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text));

    } catch (e) {

      // loading stop
      UFullScreenLoader.stopLoading();

      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
