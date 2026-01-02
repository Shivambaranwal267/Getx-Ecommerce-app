import 'package:ecommerce/data/repositories/banner/banner_repository.dart';
import 'package:ecommerce/data/repositories/brand/brand_repository.dart';
import 'package:ecommerce/data/repositories/category/category_repository.dart';
import 'package:ecommerce/data/repositories/product/product_repository.dart';
import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/dummy_data.dart';
import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/onboarding.dart';
import 'package:ecommerce/features/authentication/screens/signup/verify_email.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final localStorage = GetStorage();

  final _auth = FirebaseAuth.instance;
  final _logger = Logger();

  User? get currentUser => _auth.currentUser;

  @override
  void onReady() {
    // Remove the Splash Screen
    FlutterNativeSplash.remove();

    // redirect method
    screenRedirect();

    // Get.put(CategoryRepository()).uploadCategories(UDummyData.categories);
    // Get.put(BannerRepository()).uploadBanners(UDummyData.banner);
    // Get.put(BrandRepository()).uploadBrands(UDummyData.brands);
    // Get.put(ProductRepository()).uploadProducts(UDummyData.products);
    // Get.put(CategoryRepository()).uploadBrandCategory(UDummyData.brandCategory);
    // Get.put(CategoryRepository()).uploadProductCategory(UDummyData.productCategory);

  }

  /// Function to redirect to the right screen
  Future<void> screenRedirect() async{

    final user = _auth.currentUser;
    if (user != null) {

      // Check if user is verified
      if (user.emailVerified) {

        // if verified, go to navigation menu
        Get.offAll(() => NavigationMenu());

        // initialize user specific box
        await GetStorage.init(user.uid);

      } else {

        // if not-verified, go to verify-email-screen
        Get.offAll(() => VerifyEmailScreen(email: user.email));
      }
    } else {

      // write isFirstTime if null
      localStorage.writeIfNull('isFirstTime', true);

      // CHeck if user is first time
      localStorage.read('isFirstTime') != true
          ? Get.to(() => LoginScreen())
          : Get.to(() => OnboardingScreen());
    }
  }

  /// Sign up email & password authentication
  Future<UserCredential> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  /// Login In email & password authentication
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  /// Sign In google with google-authentication
  Future<UserCredential> signInWithGoogle() async {
    try {

      // Show Popup to select google account
      final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();

      // Get the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleAccount?.authentication;

      // create Credentials
      final OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken
      );

      // Sign in with google credentials
      UserCredential userCredential =  await _auth.signInWithCredential(credential);

      return userCredential;


    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  /// Send Mail verification to email Inbox
  Future<void> sendEmailVerification() async {
    try {
      _logger.i("Current user: ${_auth.currentUser}");
      _logger.i("is emailVerified: ${_auth.currentUser?.emailVerified}");

      /// send mail for email-verification
      await _auth.currentUser?.sendEmailVerification();
      _logger.i("Verification email sent successfully!");
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  /// Send Mail to Reset Password in Forget Password
  Future<void> sendPasswordResetEmail(String email) async {
    try {

      _logger.i("sending for reset email: ${_auth.sendPasswordResetEmail(email: email)}");

      /// send mail for password reset
      await _auth.sendPasswordResetEmail(email: email);
      _logger.i("Sending mail for Password reset successfully!");
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  /// Send Mail to Reset Password in Forget Password
  Future<void> reAuthenticateUserWithEmailAndPassword(String email, String password) async {
    try {

      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
      await currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  /// user logout
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();

      /// login Screen
      Get.offAll(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  /// [DeleteUser] - Delete User Account
  Future<void> deleteAccount() async {
    try{
      // Delete User record
      await UserRepository.instance.removeUserRecord(currentUser!.uid);

      // Remove profile picture from cloudinary
      String publicId = UserController.instance.user.value.publicId;
      if(publicId.isNotEmpty) {
        UserRepository.instance.deleteProfilePicture(publicId);
      }

      await _auth.currentUser?.delete();

    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }



}
