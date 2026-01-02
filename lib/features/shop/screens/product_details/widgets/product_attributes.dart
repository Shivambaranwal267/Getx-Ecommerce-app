import 'package:ecommerce/common/widgets/chips/choice_chip.dart';
import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:ecommerce/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/product/variation_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UProductAttributes extends StatelessWidget {
  const UProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());

    return Obx(
        () => Column(
        children: [

          /// Selected Attributes Pricing & Description
          if(controller.selectedVariation.value.id.isNotEmpty)
          URoundedContainer(
            padding: EdgeInsets.all(USizes.md),
            backgroundColor: dark ? UColors.darkGrey : UColors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title, Price & Actual Price
                Row(
                  children: [
                    // title
                    USectionHeading(title: 'Variation', showActionButton: false),
                    SizedBox(width: USizes.spaceBtwItems),

                    Column(
                      children: [
                        Row(
                          children: [
                            // price
                            UProductTitleText(title: 'Price : ', smallSize: true),

                            // Actual Price
                            if(controller.selectedVariation.value.salePrice > 0)
                            Text(
                              '${UTexts.currency}${controller.selectedVariation.value.price.toStringAsFixed(0)}',
                              style: Theme.of(context).textTheme.titleSmall!
                                  .apply(decoration: TextDecoration.lineThrough),
                            ),
                            SizedBox(width: USizes.spaceBtwItems),

                            // sell price
                            UProductPriceText(price: controller.getVariationPrice()),
                          ],
                        ),

                        /// Stock Status
                        Row(
                          children: [
                            // Stock
                            UProductTitleText(title: 'Stock : ', smallSize: true),
                            Text(
                              controller.variationStockStatus.value,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                /// Attribute Description
                UProductTitleText(
                  title: controller.selectedVariation.value.description ?? '',
                  smallSize: true,
                  maxLines: 4,
                ),
              ],
            ),
          ),

          SizedBox(height: USizes.spaceBtwItems),

        /// product Attributes get
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: product.productAttributes!.map((attribute) {
             return Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    USectionHeading(title: attribute.name ?? '', showActionButton: false),
                    SizedBox(height: USizes.spaceBtwItems / 2),

                    Obx(() => Wrap(
                        spacing: USizes.sm,
                        children: attribute.values!.map((attributeValue) {
                          final isSelected = controller.selectedAttributes[attribute.name] == attributeValue;
                          bool available = controller.getAttributesAvailabilityInVariation(product.productVariations!, attribute.name!).
                                                 contains(attributeValue);
                          return UChoiceChip(
                              text: attributeValue,
                              selected: isSelected,
                              onSelected: available ? (selected) {
                                if(available && selected) {
                                  controller.onAttributeSelected(product, attribute.name, attributeValue);
                                }
                              } : null);
                        }).toList()
                      ),
                    ),
                  ],
                );
           }).toList(),
         )


         // /// Attributes - Colors
         //  Column(
         //    crossAxisAlignment : CrossAxisAlignment.start,
         //    children: [
         //      USectionHeading(title: 'Colors', showActionButton: false),
         //      SizedBox(height: USizes.spaceBtwItems / 2),
         //
         //      Wrap(
         //        spacing: USizes.sm,
         //        children: [
         //          UChoiceChip(text: 'Red', selected: true, onSelected: (value){}),
         //          UChoiceChip(text: 'Blue', selected: false, onSelected: (value){}),
         //          UChoiceChip(text: 'Yellow', selected: false, onSelected: (value){})
         //        ],
         //      )
         //    ],
         //  ),



          /// Attributes - Sizes
          // Column(
          //   crossAxisAlignment : CrossAxisAlignment.start,
          //   children: [
          //     USectionHeading(title: 'Sizes', showActionButton: false),
          //     SizedBox(height: USizes.spaceBtwItems / 2),
          //
          //     Wrap(
          //       spacing: USizes.sm,
          //       children: [
          //         UChoiceChip(text: 'Small', selected: true, onSelected: (value){}),
          //         UChoiceChip(text: 'Medium', selected: false, onSelected: (value){}),
          //         UChoiceChip(text: 'Large', selected: false, onSelected: (value){})
          //       ],
          //     )
          //   ],
          // ),





        ],
      ),
    );
  }
}


