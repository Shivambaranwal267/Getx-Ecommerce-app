import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/utils/constants/keys.dart';
import 'package:ecommerce/utils/helpers/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/snackbar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// Variables
  final loginFormKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  RxBool rememberMe = false.obs;

  final _userController = Get.put(UserController());
  final localStorage = GetStorage();

  @override
  void onInit() {
    email.text = localStorage.read(UKeys.rememberMeEmail) ?? '';
    password.text = localStorage.read(UKeys.rememberMePassword) ?? '';
    super.onInit();
  }

  /// Login With Email & Password In Authentication
  Future<void> loginWithEmailAndPassword() async {
    try {
      /// Start Loading
      UFullScreenLoader.openLoadingDialog('Logging you in...');

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      /// Form Validation
      if (!loginFormKey.currentState!.validate()){
        UFullScreenLoader.stopLoading();
        return;
      }

      /// Save Data if remember me is checked
      if (rememberMe.value) {
        localStorage.write(UKeys.rememberMeEmail, email.text.trim());
        localStorage.write(UKeys.rememberMePassword, password.text.trim());
      }

      /// Login user with Email & Password
      await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      /// success message
      USnackBarHelpers.successSnackBar(title: 'Congratulations!', message: 'You have login Successfully.');

      /// Stop Loading
      UFullScreenLoader.stopLoading();

      /// Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (err) {
      /// stop loading
      UFullScreenLoader.stopLoading();

      /// Error Message
      USnackBarHelpers.errorSnackBar(title: "Login Failed", message: err.toString());
    }
  }

  /// Google Sign In Authentication
  Future<void> googleSignIn() async {
    try {

      /// Start Loading
      UFullScreenLoader.openLoadingDialog('Logging you in...');

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
        return;
      }

      /// Google Authentication with userCredentials
      UserCredential userCredential = await AuthenticationRepository.instance.signInWithGoogle();

      /// Save record
      _userController.saveUserRecord(userCredential);

      /// success message
      USnackBarHelpers.successSnackBar(title: 'Congratulations!', message: 'You have login Successfully With Google Account.');

      /// Stop Loading
      UFullScreenLoader.stopLoading();

      /// Redirect
      AuthenticationRepository.instance.screenRedirect();

    } catch(err) {
      /// stop loading
      UFullScreenLoader.stopLoading();

      /// Error message
      USnackBarHelpers.errorSnackBar(title: "Login Failed", message: err.toString());
    }
  }

}
