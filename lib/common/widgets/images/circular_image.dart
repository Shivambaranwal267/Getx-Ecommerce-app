 import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/common/widgets/shimmer/shimmer_effect.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';


class UCircularImage extends StatelessWidget {
  const  UCircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.overlayColor,
    this.backgroundColor,
    required this.image,
    this.fit = BoxFit.cover,
    this.padding = USizes.sm,
    this.isNetworkImage = false,
    this.showBorder = false,
    this.borderColor = UColors.primary,
    this.borderWidth = 1.0,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;
  final bool showBorder;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);

    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? (dark ? UColors.dark : UColors.light),
        borderRadius: BorderRadius.circular(120),
        border: showBorder
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
        ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(120),
        child: isNetworkImage ? CachedNetworkImage(
                fit: fit, color: overlayColor,
                progressIndicatorBuilder: (context, url, progress) => UShimmerEffect(width: 55, height: 55),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageUrl: image)
            : Image(fit: fit, image: AssetImage(image)),
        // child: Image(image: isNetworkImage ? NetworkImage(image) : AssetImage(image) as ImageProvider),
      ),
    );
  }
}
