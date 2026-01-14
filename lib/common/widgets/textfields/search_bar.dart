import 'package:ecommerce/common/style/shadow.dart';
import 'package:ecommerce/features/shop/screens/search_store/search_store.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class USearchBar extends StatelessWidget {
  const USearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: 0,
      right: USizes.spaceBtwSections,
      left: USizes.spaceBtwSections,
      child: GestureDetector(
        onTap: () => Get.to(() => SearchStoreScreen()),
        child: Container(
          height: USizes.searchBarHeight,
          padding: EdgeInsets.symmetric(horizontal: USizes.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(USizes.borderRadiusLg),
            color: dark ? UColors.dark : UColors.light,
            boxShadow: UShadow.searchBarShadow,
          ),
          child: Row(
            children: [
              // Search Icon
              Icon(Iconsax.search_normal, color: UColors.darkerGrey),

              SizedBox(width: USizes.spaceBtwItems),

              // Search Bar title
              Text(UTexts.searchBarTitle, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
