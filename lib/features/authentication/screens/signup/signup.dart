import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/button/social_buttons.dart';
import 'package:ecommerce/common/widgets/login_signup/form_divider.dart';
import 'package:ecommerce/features/authentication/controllers/signup/signup_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
   Get.put(SignUpController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Text(
                UTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              SizedBox(height: USizes.spaceBtwSections),

              /// Form
              USignupForm(),
              SizedBox(height: USizes.spaceBtwSections),

              /// Divider
              UFormDivider(title: UTexts.orSignupWith),
              SizedBox(height: USizes.spaceBtwSections),

              /// Footer
              USocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
