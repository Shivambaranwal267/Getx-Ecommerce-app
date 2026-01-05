import 'package:ecommerce/common/widgets/loaders/circular_loader.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/data/repositories/address/address_repository.dart';
import 'package:ecommerce/features/personalization/models/address_model.dart';
import 'package:ecommerce/features/personalization/screens/address/widgets/single_address.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:ecommerce/utils/helpers/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/snackbar_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  /// Variables
  final _repository = Get.put(AddressRepository());
  Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  RxBool refreshData = false.obs;

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  /// Function to add new address of the User
  Future<void> addNewAddress() async {
    try {
      // start loading
      UFullScreenLoader.openLoadingDialog('Adding Address...');

      // check Internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // Create Address Model
      AddressModel address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        dateTime: DateTime.now(),
        selectedAddress: true,
      );

      // Save Address
      String addressId = await _repository.addAddress(address);

      // Update Address Id
      address.id = addressId;

      // update address Id
      selectAddress(address);

      // Stop Loading
      UFullScreenLoader.stopLoading();

      // Show Success Message
      USnackBarHelpers.successSnackBar(title: 'Congratulations', message: 'Your address has been save successfully');

      // Refresh Addresses Data
      refreshData.toggle();

      // Reset text fields
      resetFormFields();

      // Go Back Page
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);

    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    }
  }

  /// Function to get all address of Specific User
  Future<List<AddressModel>> getAllAddresses() async {
    try{
      List<AddressModel> addresses = await _repository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere((address) => address.selectedAddress, orElse: () => AddressModel.empty());
      return addresses;

    } catch(e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
      return [];
    }
  }

  /// Function to select address
  Future<void> selectAddress(AddressModel newSelectedAddress) async {
    try{
      // start loading
      Get.defaultDialog(
        title: '',
        onWillPop: () async => false,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: UCircularLoader()
      );

      // un-select the already selected address
      if(selectedAddress.value.id.isNotEmpty) {
        await _repository.updateSelectedField(selectedAddress.value.id, false);
      }

      // assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // Get the Selected Address to true in the firebase
      await _repository.updateSelectedField(selectedAddress.value.id, true);

      // Go back
      Get.back();

    } catch(e) {
      Get.back();
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    }

  }

  /// FUnction to show Bottom Sheet to select address
  Future<void> selectNewAddressBottomSheet(BuildContext context) {
    return showModalBottomSheet(context: context, builder: (context) => SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(USizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            USectionHeading(title: 'Select Address', showActionButton: false),
            SizedBox(height: USizes.spaceBtwItems),
            FutureBuilder(
                future: getAllAddresses(),
                builder: (context, snapshot) {

                  /// Handle Error, Loading & Empty Sates
                  final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                  if(widget != null) return widget;

                  return ListView.separated(
                    shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (context, index) => SizedBox(height: USizes.spaceBtwItems),
                    itemBuilder: (context, index) => USingleAddress(address: snapshot.data![index], onTap: () {
                      selectedAddress(snapshot.data![index]);
                      Get.back();
                    }),
                  );

                },)
          ],
        ),
      ),
    ));
  }

  /// Function to reset All-Fields of the form
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();

    addressFormKey.currentState!.reset();
  }


}
