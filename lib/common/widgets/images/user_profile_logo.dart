import 'package:ecommerce/common/widgets/images/circular_image.dart';
import 'package:ecommerce/common/widgets/shimmer/shimmer_effect.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileLogo extends StatelessWidget {
  const UserProfileLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Obx(() {
      bool isProfileAvailable = controller.user.value.profilePicture.isNotEmpty;

      /// [Loading State]
      if(controller.isProfileUploading.value){
        return UShimmerEffect(width: 120.0, height: 120.0, radius: 120);
      }

      return UCircularImage(
        image: isProfileAvailable ? controller.user.value.profilePicture : UImages.profileLogo,
        height: 120.0, width: 120.0, borderWidth: 5.0, padding: 0, isNetworkImage: isProfileAvailable
      );
    });
  }
}
