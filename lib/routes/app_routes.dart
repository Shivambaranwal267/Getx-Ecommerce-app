import 'package:ecommerce/features/authentication/screens/forget_password/forget_password.dart';
import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/onboarding.dart';
import 'package:ecommerce/features/authentication/screens/signup/signup.dart';
import 'package:ecommerce/features/authentication/screens/signup/verify_email.dart';
import 'package:ecommerce/features/personalization/screens/address/address.dart';
import 'package:ecommerce/features/personalization/screens/edit_profile/edit_profile.dart';
import 'package:ecommerce/features/personalization/screens/profile/profile.dart';
import 'package:ecommerce/features/shop/screens/cart/cart.dart';
import 'package:ecommerce/features/shop/screens/checkout/checkout.dart';
import 'package:ecommerce/features/shop/screens/home/home.dart';
import 'package:ecommerce/features/shop/screens/order/order.dart';
import 'package:ecommerce/features/shop/screens/store/store.dart';
import 'package:ecommerce/features/shop/screens/wishlist/wishlist.dart';
import 'package:ecommerce/loading.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:get/get.dart';
import 'routes.dart';

class UAppRoutes{

  static final screens = [
    GetPage(name: URoutes.home, page: () => const NavigationMenu()),
    GetPage(name: URoutes.store, page: () => const StoreScreen(),),
    GetPage(name: URoutes.wishlist, page: () => const WishlistScreen(),),
    GetPage(name: URoutes.profile, page: () => const ProfileScreen(),),
    GetPage(name: URoutes.order, page: () => const OrderScreen(),),
    GetPage(name: URoutes.checkout, page: () => const CheckoutScreen(),),
    GetPage(name: URoutes.cart, page: () => const CartScreen(),),
    GetPage(name: URoutes.editProfile, page: () => const EditProfileScreen(),),
    GetPage(name: URoutes.userAddress, page: () => const AddressScreen(),),
    GetPage(name: URoutes.signup, page: () => const SignupScreen(),),
    GetPage(name: URoutes.verifyEmail, page: () => const VerifyEmailScreen(),),
    GetPage(name: URoutes.signIn, page: () => const LoginScreen(),),
    GetPage(name: URoutes.forgetPassword, page: () => const ForgetPasswordScreen(),),
    GetPage(name: URoutes.onBoarding, page: () => const OnboardingScreen(),),
  ];
}