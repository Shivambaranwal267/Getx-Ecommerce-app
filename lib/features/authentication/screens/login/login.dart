import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/button/social_buttons.dart';
import 'package:ecommerce/common/widgets/login_signup/form_divider.dart';
import 'package:ecommerce/features/authentication/controllers/login/login_contoller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// ----------header-------
              /// title and subtitle
              ULoginHeader(),

              SizedBox(height: USizes.spaceBtwSections),

              /// ----------form-------
              ULoginForm(),

              SizedBox(height: USizes.spaceBtwSections),

              /// ----------Divider-------
              UFormDivider(title: UTexts.orSignInWith),

              SizedBox(height: USizes.spaceBtwSections),

              /// ----------Footer-------
              /// Social button
              USocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
