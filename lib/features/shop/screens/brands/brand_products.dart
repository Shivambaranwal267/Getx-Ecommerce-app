import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/brands/brand_card.dart';
import 'package:ecommerce/common/widgets/products/sortable_products.dart';
import 'package:ecommerce/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:ecommerce/features/shop/controllers/brand/brand_controller.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key, required this.title, required this.brand});

  final String title;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;

    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              /// Brand
              UBrandCard(brand: brand),
              const SizedBox(height: USizes.spaceBtwSections),

              /// Brand Products
              FutureBuilder(
                future: controller.getBrandProducts(brand.id),
                builder: (context, snapshot) {

                  /// Handle Loading, Error And Empty States
                  const loader = UVerticalProductShimmer();
                  Widget? widget =  UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                  if(widget != null) return widget;

                  /// Data Found
                  List<ProductModel> products = snapshot.data!;
                  return USortableProducts(products: products);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
