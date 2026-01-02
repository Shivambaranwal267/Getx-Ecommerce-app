import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';

import 'widgets/orders_list.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: UAppBar(showBackArrow: true,title: Text('My Orders', style: Theme.of(context).textTheme.headlineSmall)),

      body: Padding(padding: UPadding.screenPadding,
      child: UOrdersListItems()),
    );
  }
}
