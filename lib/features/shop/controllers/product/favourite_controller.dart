import 'dart:convert';

import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/data/repositories/product/product_repository.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/popups/snackbar_helpers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavouriteController  extends GetxController{
  static FavouriteController get instance => Get.find();

  /// Variables
  RxMap<String, bool> favourites = <String, bool>{}.obs;
  final _storage = GetStorage(AuthenticationRepository.instance.currentUser!.uid);


  @override
  void onInit() {
    initFavourites();
    super.onInit();
  }

  /// Function to load Favourites from local storage
  Future<void> initFavourites() async {
    final encodedFavourites = _storage.read('favourites');

    if (encodedFavourites == null) {
      favourites.clear();
      return;
    }

    final Map<String, dynamic> storedFavourites =
    jsonDecode(encodedFavourites) as Map<String, dynamic>;

    favourites.assignAll(
      storedFavourites.map(
            (key, value) => MapEntry(key, value as bool),
      ),
    );
  }


  /// Function to Add OR Remove Product from wishlist
  void toggleFavouriteProduct(String productId) {
    if(favourites.containsKey(productId)){
       favourites.remove(productId);
       saveFavouritesToStorage();
       USnackBarHelpers.customToast(message: 'Product has been removed from the Wishlist');
    } else {
      favourites[productId] = true;
      saveFavouritesToStorage();
      USnackBarHelpers.customToast(message: 'Product has been added to the Wishlist');
    }
  }

  /// Function to store favourites in local storage
  void saveFavouritesToStorage() {
   String encodedFavourites = jsonEncode(favourites);
    _storage.write('favourites',  encodedFavourites);
  }

  /// Check is product available in favourite
  bool isFavourite (String productId) {
    return favourites[productId] ?? false;
  }

  /// Function to get all favourite product only
  Future<List<ProductModel>> getFavouriteProducts() async {
    final productsIds = favourites.keys.toList();
    return await ProductRepository.instance.getFavouriteProducts(productsIds);
  }


}

