import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import 'shimmer_effect.dart';

class UAddressesShimmer extends StatelessWidget {
  const UAddressesShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(height: USizes.spaceBtwItems),
        itemCount: 4,
        itemBuilder: (context, index) => UShimmerEffect(width: double.infinity, height: 150)
    );
  }
}