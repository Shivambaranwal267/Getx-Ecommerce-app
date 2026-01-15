import 'package:ecommerce/data/repositories/brand/brand_repository.dart';
import 'package:ecommerce/data/repositories/product/product_repository.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/popups/snackbar_helpers.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class BrandController  extends GetxController{
  static BrandController get instance => Get.find();

  /// Variables
  final _repository = Get.put(BrandRepository());
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  RxBool isLoading = false.obs;

  final _logger = Logger();

  @override
  void onInit() {
    getBrands();
    super.onInit();
  }

  /// Get ALl Brands and Featured Brands
  Future<void> getBrands() async {
    try {
      // start loading
      isLoading.value = true;

      List<BrandModel> allBrands = await _repository.fetchBrands();
      // _logger.d("Brands: $featuredBrands");
      this.allBrands.assignAll(allBrands);
      
      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false ).toList());
      
    } catch (err) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!',message: err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Get Brand Specific Products
  Future<List<ProductModel>> getBrandProducts(String brandId, {int limit = -1}) async {
    try {
     List<ProductModel> products = await ProductRepository.instance.getProductsForBrand(brandId: brandId, limit: limit);
     return products;

    } catch(e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
      return [];
    }
  }

  /// Get Brands for specific Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try{
      final brands = await _repository.fetchBrandsForCategory(categoryId);
      return brands;

    } catch(e) {
      USnackBarHelpers.errorSnackBar(title: "Failed!", message: e.toString());
      return [];
    }
  }








}