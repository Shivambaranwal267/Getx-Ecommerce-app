import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/image_text/vertical_image_text.dart';
import 'package:ecommerce/common/widgets/images/rounded_images.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchStoreScreen extends StatelessWidget {
  const SearchStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-------------------------[APPBAR]---------------------------///
      appBar: UAppBar(showBackArrow: true, title: Text('Search', style: Theme.of(context).textTheme.headlineMedium)),

      ///-------------------------[BODY]---------------------------///
      body: SingleChildScrollView(
        child: Padding(
            padding: UPadding.screenPadding,
          child: Column(
            children: [
              /// Search Field
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.search_normal),
                  hintText: 'Search in store'
                ),
              ),

              const SizedBox(height: USizes.spaceBtwSections),

              /// Brands
              USectionHeading(title: 'Brands'),

              const SizedBox(height: USizes.spaceBtwItems),

              Wrap(
                spacing: USizes.spaceBtwItems,
                runSpacing: USizes.spaceBtwItems,
                children: [
                  UVerticalImageText(title: 'Nike', image: UImages.nikeLogo, textColor: UColors.black),
                  UVerticalImageText(title: 'Nike', image: UImages.nikeLogo, textColor: UColors.black),
                  UVerticalImageText(title: 'Nike', image: UImages.nikeLogo, textColor: UColors.black),
                  UVerticalImageText(title: 'Nike', image: UImages.nikeLogo, textColor: UColors.black),
                  UVerticalImageText(title: 'Nike', image: UImages.nikeLogo, textColor: UColors.black),
                  UVerticalImageText(title: 'Nike', image: UImages.nikeLogo, textColor: UColors.black),
                  UVerticalImageText(title: 'Nike', image: UImages.nikeLogo, textColor: UColors.black),
                  UVerticalImageText(title: 'Nike', image: UImages.nikeLogo, textColor: UColors.black),
                  UVerticalImageText(title: 'Nike', image: UImages.nikeLogo, textColor: UColors.black),
                  UVerticalImageText(title: 'Nike', image: UImages.nikeLogo, textColor: UColors.black),
                ],
              ),

              /// Categories
              USectionHeading(title: 'Categories'),

              const SizedBox(height: USizes.spaceBtwSections),

              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: URoundedImage(width: USizes.iconLg, height: USizes.iconLg, imageUrl: UImages.clothesIcon, borderRadius: 0),
                    title: Text('Clothes'),

                  );
                },
              )


            ],
          ),
        ),
      ),
    );
  }
}
