import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/button/elevated_button.dart';
import 'package:ecommerce/features/personalization/controllers/address_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Scaffold(
      ///-------------------APPBAR--------------------
      appBar: UAppBar(showBackArrow: true, title: Text('Add New Address', style: Theme.of(context).textTheme.headlineMedium)),

      ///-------------------BODY--------------------
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: <Widget>[
                // Name
                TextFormField(
                  controller: controller.name,
                  validator: (value) =>
                      UValidator.validateEmptyText('Name', value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Name',
                  ),
                ),

                SizedBox(height: USizes.spaceBtwInputFields),

                // Phone Number
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: UValidator.validatePhoneNumber,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: 'Phone Number',
                  ),
                ),
                SizedBox(height: USizes.spaceBtwInputFields),

                Row(
                  children: [
                    // Street
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        validator: (value) =>
                            UValidator.validateEmptyText('Street', value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: 'Street',
                        ),
                      ),
                    ),

                    SizedBox(width: USizes.spaceBtwInputFields),

                    // Postal Code
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator: (value) =>
                            UValidator.validateEmptyText('Postal Code', value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'Postal Code',
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: USizes.spaceBtwInputFields),

                Row(
                  children: [
                    // City
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator: (value) =>
                            UValidator.validateEmptyText('City', value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: 'City',
                        ),
                      ),
                    ),

                    SizedBox(width: USizes.spaceBtwInputFields),

                    // State
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        validator: (value) =>
                            UValidator.validateEmptyText('State', value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.activity),
                          labelText: 'State',
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: USizes.spaceBtwInputFields),

                // Country
                TextFormField(
                  controller: controller.country,
                  validator: (value) =>
                      UValidator.validateEmptyText('Country', value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.global),
                    labelText: 'Country',
                  ),
                ),

                SizedBox(height: USizes.spaceBtwSections),

                UElevatedButton(
                  onPressed: controller.addNewAddress,
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
