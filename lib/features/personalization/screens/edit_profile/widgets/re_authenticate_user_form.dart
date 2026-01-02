import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/button/elevated_button.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthenticateUserForm extends StatelessWidget {
  const ReAuthenticateUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: UAppBar(showBackArrow: true, title: Text('Re-Authenticate User')),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              children: [
                /// Email
                TextFormField(
                  controller: controller.email,
                  validator: UValidator.validateEmail,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: UTexts.email,
                  ),
                ),

                SizedBox(height: USizes.spaceBtwInputFields),

                /// Password
                Obx(
                  () => TextFormField(
                    controller: controller.password,
                    obscureText: controller.isPasswordVisible.value,
                    validator: (value) =>
                        UValidator.validateEmptyText('Password', value),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      suffixIcon: IconButton(onPressed: () => controller.isPasswordVisible.toggle(), icon: Icon(controller.isPasswordVisible.value ? Iconsax.eye : Iconsax.eye_slash)),
                      labelText: UTexts.password,
                    ),
                  ),
                ),

                
                SizedBox(height: USizes.spaceBtwSections),
                
                /// Login Button
                UElevatedButton(onPressed: controller.reAuthenticateUser, child: Text('Verify'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
