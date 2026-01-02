import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/button/elevated_button.dart';
import 'package:ecommerce/features/personalization/controllers/change_name_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangeNameController());
    return Scaffold(
      /// Appbar
      appBar: UAppBar(showBackArrow: true, title: Text('Update Name', style: Theme.of(context).textTheme.headlineSmall)),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
            padding: UPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// Heading
              Text("Update your name to keep your profile accurate and personalized",
              style:Theme.of(context).textTheme.labelMedium),
              SizedBox(height: USizes.spaceBtwSections),


              /// Form
              Form(
                key: controller.updateUserFormKey,
                  child: Column(
                    children: <Widget>[
                      // First Name
                      TextFormField(
                        controller: controller.firstName,
                        validator: (value) => UValidator.validateEmptyText('First Name', value),
                        decoration: InputDecoration(
                          labelText: UTexts.firstName, prefixIcon: Icon(Iconsax.user)
                        ),
                      ),
                      
                      SizedBox(height: USizes.spaceBtwInputFields),

                      // last Name
                      TextFormField(
                        controller: controller.lastName,
                        validator: (value) => UValidator.validateEmptyText('Last Name', value),
                        decoration: InputDecoration(
                            labelText: UTexts.lastName, prefixIcon: Icon(Iconsax.user)
                        ),
                      ),
                      
                    ],
                  )),
              SizedBox(height: USizes.spaceBtwSections),
              
              /// Save Buttons
              UElevatedButton(onPressed: controller.updateUserName, child: Text('Save'))
              
            ],
          ),
        ),
      ),
    );
  }
}
