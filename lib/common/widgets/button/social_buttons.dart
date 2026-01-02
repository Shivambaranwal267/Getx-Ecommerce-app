import 'package:ecommerce/features/authentication/controllers/login/login_contoller.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class USocialButtons extends StatelessWidget {
  const USocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Google Button
        buildButton(UImages.googleIcon, controller.googleSignIn),

        SizedBox(width: USizes.spaceBtwItems),

        /// facebook Button
        buildButton(UImages.facebookIcon, () {}),
      ],
    );
  }
}

Container buildButton(String image, VoidCallback onPressed) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: UColors.grey),
      borderRadius: BorderRadius.circular(100),
    ),
    child: IconButton(
      onPressed: onPressed,
      icon: Image.asset(image, width: USizes.iconMd, height: USizes.iconMd),
    ),
  );
}
