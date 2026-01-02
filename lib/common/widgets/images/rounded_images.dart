// import 'package:ecommerce/utils/constants/sizes.dart';
// import 'package:flutter/material.dart';
//
// class URoundedImage extends StatelessWidget {
//   const URoundedImage({
//     super.key,
//     this.width,
//     this.height,
//     required this.imageUrl,
//     this.applyImageRadius = true,
//     this.border,
//     this.backgroundColor,
//     this.fit = BoxFit.contain,
//     this.padding,
//     this.isNetworkImage = false,
//     this.onTap,
//     this.borderRadius = USizes.md,
//   });
//
//   final double? width, height;
//   final String? imageUrl;
//   final bool applyImageRadius;
//   final BoxBorder? border;
//   final Color? backgroundColor;
//   final BoxFit? fit;
//   final EdgeInsetsGeometry? padding;
//   final bool isNetworkImage;
//   final VoidCallback? onTap;
//   final double borderRadius;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: width,
//         height: height,
//         padding: padding,
//         decoration: BoxDecoration(
//           border: border,
//           color: backgroundColor,
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//         child: ClipRRect(
//           borderRadius: applyImageRadius
//               ? BorderRadius.circular(borderRadius)
//               : BorderRadius.zero,
//           // child: isNetworkImage
//           //     ? CachedNetworkImage(
//           //         imageUrl: imageUrl,
//           //         errorWidget: (context, url, error) => Icon(Icons.error),
//           //       )
//           //     : Image(image: AssetImage(imageUrl), fit: fit),
//           child: Image(image: isNetworkImage ? NetworkImage(imageUrl) : AssetImage(imageUrl),fit: fit),
//         ),
//       ),
//     );
//   }
// }

import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class URoundedImage extends StatelessWidget {
  const URoundedImage({
    super.key,
    this.width,
    this.height,
    this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onTap,
    this.borderRadius = USizes.md,
    this.placeholderAsset =
        '', // optional fallback
  });

  final double? width, height;
  final String? imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onTap;
  final double borderRadius;
  final String placeholderAsset; // fallback asset

  @override
  Widget build(BuildContext context) {
    // Determine final image provider safely
    Widget imageWidget;

    if (isNetworkImage) {
      final String url = imageUrl?.trim() ?? '';
      if (url.isEmpty || !url.startsWith('http')) {
        // Invalid or empty network URL → show placeholder
        imageWidget = Image.asset(placeholderAsset, fit: fit);
      } else {
        imageWidget = Image.network(
          url,
          fit: fit,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(placeholderAsset, fit: fit);
          },
        );
      }
    } else {
      // Local asset – safe fallback if null
      imageWidget = Image.asset(
        imageUrl ?? placeholderAsset,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(placeholderAsset);
        },
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: imageWidget,
        ),
      ),
    );
  }
}
