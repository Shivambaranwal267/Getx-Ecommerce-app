import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/features/personalization/controllers/address_controller.dart';
import 'package:ecommerce/features/personalization/models/address_model.dart';
import 'package:ecommerce/features/personalization/screens/address/add_new_address.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'widgets/single_address.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Scaffold(

      /// APPBAR
      appBar: UAppBar(showBackArrow: true, title: Text('Addresses', style: Theme.of(context).textTheme.headlineMedium)),

      /// BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Obx(
            () => FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.getAllAddresses(),
              builder: (context, snapshot) {

                /// Handle Error, Loading & Empty
                final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                if (widget != null) return widget;

                /// If Data Found
                List<AddressModel> addresses = snapshot.data!;

                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: addresses.length,
                  separatorBuilder: (context, index) => SizedBox(height: USizes.spaceBtwItems),
                  itemBuilder: (context, index) {
                    return USingleAddress(
                        onTap: () => controller.selectAddress(addresses[index]),
                        address: addresses[index]);
                  },
                );
              },
            ),
          ),
        ),
      ),

      /// FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddNewAddressScreen()),
        backgroundColor: UColors.primary,
        child: Icon(Iconsax.add, color: UColors.white),
      ),
    );
  }
}
