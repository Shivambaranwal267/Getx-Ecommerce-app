import 'package:ecommerce/common/widgets/brands/brand_showcase.dart';
import 'package:ecommerce/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:ecommerce/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:ecommerce/features/shop/controllers/brand/brand_controller.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {

    final controller = BrandController.instance;
    /// Brand Showcase
    return FutureBuilder(
      future: controller.getBrandsForCategory(category.id),
      builder: (context, snapshot) {

        final loader = Column(children: [
          UListTileShimmer(),
          SizedBox(height: USizes.spaceBtwItems),
          UBoxesShimmer(),
          SizedBox(height: USizes.spaceBtwItems)
        ]);

        /// Handle Loader , No Records , error
        final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
        if(widget != null) return widget;

        /// If Records Founds
        final brands = snapshot.data!;
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: brands.length,
          itemBuilder: (context, index) {
          final brand = brands[index];
          return FutureBuilder(
              future: controller.getBrandProducts(brand.id, limit: 3),
              builder: (context, snapshot) {

                /// Handle Loader, No Records, Error
                final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                if(widget != null) return widget;

                /// Products Found
                final products = snapshot.data!;
                return UBrandShowcase(brand: brand, images: products.map((product) => product.thumbnail).toList());
              },
          );

        },);
      }
    );
  }
}
