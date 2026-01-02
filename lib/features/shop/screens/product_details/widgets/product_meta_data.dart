import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:ecommerce/common/widgets/images/circular_image.dart';
import 'package:ecommerce/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';

class UProductMetaData extends StatelessWidget {
  const UProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    String? salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Sale Tag , Sale Price, Actual Price and Share Icon
        Row(
          children: [
            // sale Tag
            if(salePercentage != null)...[
              URoundedContainer(
                radius: USizes.sm,
                backgroundColor: UColors.yellow.withValues(alpha: 0.8),
                padding: const EdgeInsets.symmetric(
                  horizontal: USizes.sm,
                  vertical: USizes.xs,
                ),
                child: Text('$salePercentage%', style: Theme.of(context,).textTheme.labelLarge!.apply(color: UColors.black)),
              ),

              SizedBox(width: USizes.spaceBtwItems),
            ],

            // Actual Price
            if(product.productType == ProductType.single.toString() && product.salePrice > 0)...[
              Text('${UTexts.currency}${product.price.toStringAsFixed(0)}', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough)),
              SizedBox(width: USizes.spaceBtwItems),
            ],


            // Sale Price
            UProductPriceText(price: controller.getProductPrice(product), isLarge: true),

            const Spacer(),

            // Share Button
            IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          ],
        ),

        SizedBox(height: USizes.spaceBtwItems / 1.5),

        /// Product Title
        UProductTitleText(title: product.title),
        SizedBox(height: USizes.spaceBtwItems / 1.5),

        /// Product Status in stock and out of stock
        Row(
          children: [
            UProductTitleText(title: 'Status'),
            SizedBox(width: USizes.spaceBtwItems),
            Text(controller.getProductStockStatus(product.stock), style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        SizedBox(height: USizes.spaceBtwItems / 1.5),

        /// Product Brand Image with title
        Row(
          children: [

            // Brand Image
            UCircularImage(
              padding: 0,
              isNetworkImage: true,
              image:product.brand != null ? product.brand!.image : '',
              width: 32.0,
              height: 32.0,
            ),
            SizedBox(width: USizes.spaceBtwItems),

            // Brand Title
            UBrandTitleWithVerifyIcon(title: product.brand != null  ? product.brand!.name : ''),
          ],
        ),
      ],
    );
  }
}
