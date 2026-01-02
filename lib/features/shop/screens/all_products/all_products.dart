import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/products/sortable_products.dart';
import 'package:ecommerce/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:ecommerce/features/shop/controllers/product/all_products_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({
    super.key,
    this.query,
    this.futureMethod,
    required this.title,
  });

  final String title;
  final Future<List<ProductModel>>? futureMethod;
  final Query? query;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());

    return Scaffold(

      /// AppBar
      appBar: UAppBar(showBackArrow: true, title: Text(title, style: Theme.of(context).textTheme.headlineMedium)),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            builder: (context, snapshot) {

              const loader = UVerticalProductShimmer();
              final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
              if(widget != null) return widget;


              List<ProductModel> products = snapshot.data!;
              return USortableProducts(products: products);
            },
          ),
        ),
      ),
    );
  }
}
