import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/brands/brand_card.dart';
import 'package:ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/brand/brand_controller.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:ecommerce/features/shop/screens/brands/brand_products.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Brand', style: Theme.of(context).textTheme.headlineSmall),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              /// Brands heading
              USectionHeading(title: 'Brands', showActionButton: false),
              SizedBox(height: USizes.spaceBtwItems),

              /// List of Brands
              Obx(
                () {

                  if(controller.isLoading.value) {
                    return CircularProgressIndicator();
                  }

                  if(controller.allBrands.isEmpty) {
                    return Center(child: Text('Brands Not Found!'));
                  }

                  return  UGridLayout(
                    itemCount: controller.allBrands.length,
                    mainAxisExtent: 80,
                    itemBuilder: (context, index) {
                      final brand = controller.allBrands[index];
                      return  UBrandCard(
                        onTap: () => Get.to(() => BrandProductsScreen(title: brand.name, brand: brand)),
                        brand: brand,
                      );
                    }
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
