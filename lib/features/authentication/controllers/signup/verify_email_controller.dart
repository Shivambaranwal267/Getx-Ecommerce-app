import 'dart:async';

import 'package:ecommerce/common/widgets/screens/success_screen.dart';
import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/popups/snackbar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  final _logger = Logger();

  @override
  void onInit() {
    sendEmailVerification();
    setTimeForAutoRedirect();
    super.onInit();
  }

  /// Variables

  /// Sent Email Verification link to Current User
  Future<void> sendEmailVerification() async {
    try {
      _logger.i("Current user before sending: ${FirebaseAuth.instance.currentUser}");
      _logger.i("Verified status: ${FirebaseAuth.instance.currentUser?.emailVerified}");
      await AuthenticationRepository.instance.sendEmailVerification();
      _logger.i('Verification email request executed.');
      USnackBarHelpers.successSnackBar(
        title: "Email Sent",
        message: 'Please check your inbox and verify email',
      );
    } catch (err) {
      USnackBarHelpers.errorSnackBar(title: "Error", message: err.toString());
    }
  }

  /// Timer automatically redirect on Email Verification
  void setTimeForAutoRedirect() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
          () => SuccessScreen(
            title: UTexts.accountCreatedTitle,
            subTitle: UTexts.accountCreatedSubTitle,
            image: UImages.successfulPaymentIcon,
            onTap: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        );
      }
    });
  }

  Future<void> checkEmailVerificationStatus() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null && currentUser.emailVerified) {
        Get.off(
          () => SuccessScreen(
            title: UTexts.accountCreatedTitle,
            subTitle: UTexts.accountCreatedSubTitle,
            image: UImages.successfulPaymentIcon,
            onTap: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        );
      }
    } catch (err) {
      USnackBarHelpers.errorSnackBar(title: 'Error', message: err.toString());
    }
  }
}
