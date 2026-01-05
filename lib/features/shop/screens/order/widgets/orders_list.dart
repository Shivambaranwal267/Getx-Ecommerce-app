import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:ecommerce/common/widgets/loaders/animation_loader.dart';
import 'package:ecommerce/features/shop/controllers/order/order_controller.dart';
import 'package:ecommerce/features/shop/models/order_model.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UOrdersListItems extends StatelessWidget {
  const UOrdersListItems({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunctions.isDarkMode(context);
    final controller = Get.put(OrderController());

    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (context, snapshot) {

          /// Handle Error , Loading and Empty States
          final nothingFound = UAnimationLoader(
              text: 'No order yet!',
              showActionButton: true,
            actionText: "Let's fill it",
            animation: UImages.pencilAnimation,
            onActionPressed: () => Get.offAll(() => NavigationMenu()),
          );
          final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, nothingFound: nothingFound);
          if(widget != null) return widget;

          List<OrderModel> orders = snapshot.data!;
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: USizes.spaceBtwItems),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              OrderModel order = orders[index];

              return URoundedContainer(
                showBorder: true,
                backgroundColor: dark ? UColors.dark : UColors.light,
                padding: EdgeInsets.all(USizes.md),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // first Row
                    Row(
                      children: [
                        /// Ship Icon
                        Icon(Iconsax.ship),
                        SizedBox(width: USizes.spaceBtwItems / 2),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Title
                              Text(
                                order.orderStatusText,
                                style: Theme.of(context).textTheme.bodyLarge!.apply(
                                  color: UColors.primary,
                                  fontWeightDelta: 1,
                                ),
                              ),

                              /// Date
                              Text(
                                order.formattedOrderDate,
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          onPressed: () {},
                          icon: Icon(Iconsax.arrow_right_34, size: USizes.iconSm),
                        ),
                      ],
                    ),

                    SizedBox(height: USizes.spaceBtwItems),

                    // Second Row
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              /// Tag Icon
                              Icon(Iconsax.tag),
                              SizedBox(width: USizes.spaceBtwItems / 2),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Order- title
                                    Text(
                                      'Order',
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),

                                    /// Order-value
                                    Text(
                                      order.id,
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: Row(
                            children: [
                              /// calender Icon
                              Icon(Iconsax.calendar),
                              SizedBox(width: USizes.spaceBtwItems / 2),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Shipping title
                                    Text(
                                      'Shipping Rate',
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),

                                    /// Shipping Date
                                    Text(
                                      order.formattedDeliveryDate,
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
    );
  }
}
