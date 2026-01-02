import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:ecommerce/common/widgets/images/rounded_images.dart';
import 'package:ecommerce/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UBrandCard extends StatelessWidget {
  const UBrandCard({super.key,  this.showBorder = true, this.onTap, required this.brand});

  final bool showBorder;
  final VoidCallback? onTap;

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: URoundedContainer(
        height: USizes.brandCardHeight,
        showBorder: showBorder,
        padding: EdgeInsets.all(USizes.sm),
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            /// Brand Image
            Flexible(child: URoundedImage(imageUrl: brand.image, isNetworkImage: true, backgroundColor: Colors.transparent)),

            SizedBox(width: USizes.spaceBtwItems / 2),

            /// Right Portion
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Brand Name & Verify Icon
                  UBrandTitleWithVerifyIcon(
                    title: brand.name,
                    brandTextSize: TextSizes.large,
                  ),

                  /// Text of product
                  Text(
                    '${brand.productsCount} products',
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
