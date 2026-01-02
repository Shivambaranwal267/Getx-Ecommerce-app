import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/features/personalization/screens/change_name/change_name.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'widgets/user_detail_row.dart';
import 'widgets/user_profile_with_edit_icon.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              /// User Profile with Edit Icon
              UProfileWIthEditIcon(),

              SizedBox(height: USizes.spaceBtwSections),

              /// Divider
              const Divider(),
              SizedBox(height: USizes.spaceBtwItems),

              /// heading
              USectionHeading(
                title: 'Account Settings',
                showActionButton: false,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              UserDetailRow(
                title: 'Name',
                value: controller.user.value.fullName,
                onTap: () => Get.to(() => ChangeNameScreen()),
              ),
              UserDetailRow(
                title: 'Username',
                value: controller.user.value.username,
                onTap: () {},
              ),

              /// Divider
              const Divider(),
              SizedBox(height: USizes.spaceBtwItems),

              /// Profile Section heading
              USectionHeading(
                title: 'Profile Settings',
                showActionButton: false,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              UserDetailRow(
                title: 'User ID',
                value: controller.user.value.id,
                onTap: () {},
              ),
              UserDetailRow(
                title: 'Email',
                value: controller.user.value.email,
                onTap: () {},
              ),
              UserDetailRow(
                title: 'Phone Number',
                value: '+91 ${controller.user.value.phoneNumber}',
                onTap: () {},
              ),
              UserDetailRow(title: 'Gender', value: 'Male', onTap: () {}),

              SizedBox(height: USizes.spaceBtwItems),

              /// Divider
              const Divider(),
              SizedBox(height: USizes.spaceBtwItems),

              TextButton(
                onPressed: controller.deleteAccountWarningPopup,
                child: Text(
                  'Close Account',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
