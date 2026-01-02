import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:ecommerce/common/widgets/products/cart/cart_counter_icon.dart';
import 'package:ecommerce/common/widgets/textfields/search_bar.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UStorePrimaryHeader extends StatelessWidget {
  const UStorePrimaryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Total height + 10
        Container(height: USizes.storePrimaryHeaderHeight + 10),

        /// PRIMARY HEADER CONTAINER
        UPrimaryHeaderContainer(
          height: USizes.storePrimaryHeaderHeight,
          child: UAppBar(
            title: Text(
              'Store',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium!.apply(color: UColors.white),
            ),
            actions: [UCartCounterIcon()],
          ),
        ),

        /// Search Bar
        USearchBar(),
      ],
    );
  }
}
