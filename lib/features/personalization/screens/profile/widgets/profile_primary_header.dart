import 'package:ecommerce/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:ecommerce/common/widgets/images/user_profile_logo.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UProfilePrimaryHeader extends StatelessWidget {
  const UProfilePrimaryHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Total Height
        SizedBox(height: USizes.profilePrimaryHeaderHeight + 60),

        UPrimaryHeaderContainer(
          height: USizes.profilePrimaryHeaderHeight,
          child: Container(),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(child: UserProfileLogo()),
        ),
      ],
    );
  }
}

