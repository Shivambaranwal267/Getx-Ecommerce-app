import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/device_helpers.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunctions.isDarkMode(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: USizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,

        /// Leading
        leading: showBackArrow
            ? IconButton(
                onPressed: Get.back,
                icon: Icon(
                  Iconsax.arrow_left,
                  color: dark ? UColors.white : UColors.dark,
                ),
              )
            : leadingIcon != null
            ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon))
            : null,

        // leading: showBackArrow
        //     ? IconButton(
        //   onPressed: () {
        //     if (Get.isSnackbarOpen) {
        //       Get.closeCurrentSnackbar();
        //     }
        //     Get.back();
        //   },
        //   icon: Icon(
        //     Iconsax.arrow_left,
        //     color: dark ? UColors.white : UColors.dark,
        //   ),
        // )
        //     : leadingIcon != null
        //     ? IconButton(
        //   onPressed: leadingOnPressed,
        //   icon: Icon(leadingIcon),
        // )
        //     : null,


        /// Title
        title: title,

        /// Actions
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(UDeviceHelper.getAppBarHeight());
}
