import 'package:ecommerce/common/widgets/custom_shapes/circular_container.dart';
import 'package:ecommerce/common/widgets/images/circular_image.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class UVerticalImageText extends StatelessWidget {
  const UVerticalImageText({
    super.key,
    required this.title,
    required this.image,
    required this.textColor,
    this.backgroundColor,
    this.onTap,
  });

  final String title, image;
  final Color textColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          /// Circular Image
          UCircularImage( height: 56,
          width: 56,image: image, isNetworkImage: true),


          /// Circular Container with inside Image
          // UCircularContainer(
          //   height: 56,
          //   width: 56,
          //   backgroundColor:
          //       backgroundColor ?? (dark ? UColors.dark : UColors.light),
          //   padding: EdgeInsets.all(USizes.sm),
          //   child: Image(
          //     image: AssetImage(image),
          //     fit: BoxFit.cover,
          //     // color: dark ? UColors.light : UColors.dark,
          //   ),
          // ),

          SizedBox(height: USizes.spaceBtwItems / 2),

          /// title
          SizedBox(
            width: 55,
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.apply(color: textColor),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
