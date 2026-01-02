import 'dart:io';
import 'dart:math';

import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:ecommerce/features/personalization/screens/edit_profile/widgets/re_authenticate_user_form.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/snackbar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class UserController extends GetxController {
  static UserController get instance => Get.find();

  /// variables
  final _userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  RxBool profileLoading = false.obs;
  RxBool isProfileUploading = false.obs;



  /// Re-authenticate form variables
  final email = TextEditingController();
  final password = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  final reAuthFormKey = GlobalKey<FormState>();



  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }

  /// Function to save user record
  Future<void> saveUserRecord(UserCredential userCredential) async {
    try {

      // First update RX Variable and then click if user data is already stored. if not then store
       await fetchUserDetails();

       if(user.value.id.isEmpty) {
         // Convert full name to firstname and lastname
         final nameParts = UserModel.nameParts(userCredential.user!.displayName);
         final randomNumber = Random().nextInt(9000000) + 1000000; // 7-digit random number
         final userName = '${userCredential.user!.displayName}$randomNumber';

         // create user model
         UserModel userModel = UserModel(
           id: userCredential.user!.uid,
           firstName: nameParts[0],
           lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
           username: userName,
           email: userCredential.user!.email ?? '',
           phoneNumber: userCredential.user!.phoneNumber ?? '',
           profilePicture: userCredential.user!.photoURL ?? '',
         );

         // save user record
         await _userRepository.saveUserRecord(userModel);
       }


    } catch (err) {
      USnackBarHelpers.warningSnackBar(
        title: 'Data not saved',
        message: 'Something went wrong while saving your information.',
      );
    }
  }

  /// Function to fetch user details
  Future<void> fetchUserDetails() async {
    try {
      profileLoading.value = true;
      UserModel user = await _userRepository.fetchUserDetails();
      // this.user.value = user;
      this.user(user);
    } catch (err) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// [Popup] - Popup to delete account Confirmation
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(USizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete account permanently?',
      confirm: ElevatedButton(
        onPressed: () => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: BorderSide(color: Colors.red),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: USizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Get.back(),
        child: Text('Cancel'),
      ),
    );
  }

  /// Delete Account
  Future<void> deleteUserAccount() async{
    try{
      // Start Loading
      UFullScreenLoader.openLoadingDialog('Processing....');

      // Re-Authentication User
     final authRepository = AuthenticationRepository.instance;
     final provider = authRepository.currentUser!.providerData.map((e) => e.providerId).first;


     // if Google Provider
     if(provider == 'google.com') {

      await authRepository.signInWithGoogle();
      await authRepository.deleteAccount();
      UFullScreenLoader.stopLoading();
      Get.offAll(() => LoginScreen());

     }
     // If Email/Password Provider
     else if(provider == 'password') {
       UFullScreenLoader.stopLoading();

       Get.to(() => ReAuthenticateUserForm());
     }
    }catch(err) {
      // stop loading
      UFullScreenLoader.stopLoading();

      // error message
      USnackBarHelpers.errorSnackBar(title: 'Error', message: err.toString());
    }
  }

  /// ReAuthenticate with user and password and delete the account
  Future<void> reAuthenticateUser() async {
    try {
      // Start Loading
      UFullScreenLoader.openLoadingDialog('Processing...');

      // Check Internet Connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection', );
      }

      // Form Validation
      if(!reAuthFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // Re-authenticate User with email & password
      await AuthenticationRepository.instance.reAuthenticateUserWithEmailAndPassword(email.text.trim(), password.text.trim());
      await AuthenticationRepository.instance.deleteAccount();

      // Stop loading
      UFullScreenLoader.stopLoading();

      // Success Message
      USnackBarHelpers.successSnackBar(title: 'You have Successfully remove the account');

      // Redirect
      Get.offAll(() => LoginScreen());

    } catch (err) {
      // Stop loading
      UFullScreenLoader.stopLoading();

      // Error Message
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: err.toString());
    }
  }

  /// [UploadImage] - Update User Profile Picture
  Future<void> updateUserProfilePicture() async {
    try {


      // Start Loading
      isProfileUploading.value = true;

      // Pick Image from Gallery
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 512, maxHeight: 512);
      if(image == null) return;

      // Convert XFile to File

      File file = File(image.path);

      // delete user current profile picture
      if(user.value.publicId.isNotEmpty) {
         await  _userRepository.deleteProfilePicture(user.value.publicId);
      }


      // Upload profile picture to cloudinary
      dio.Response response = await _userRepository.uploadImage(file);
      if(response.statusCode == 200) {

        // get data
        final data = response.data;
        final imageUrl = data['url'];
        final publicId = data['public_id'];

        // update profile picture from FireStore
        await _userRepository.updateSingleField({'profilePicture' : imageUrl, 'publicId' : publicId});

        // Update profile image and public id from RX User
        user.value.profilePicture = imageUrl;
        user.value.publicId == publicId;

        // user refresh
        user.refresh();

        // Update Message
        USnackBarHelpers.successSnackBar(title: 'Congratulations', message: 'Profile picture updated Successfully');

      } else {
        throw 'Failed to upload profile picture, Please try again';
      }


    } catch(err) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: err.toString());
    } finally {
      isProfileUploading.value = false;
    }

  }



  

}
