import 'package:ecommerce/data/repositories/category/category_repository.dart';
import 'package:ecommerce/data/repositories/product/product_repository.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/popups/snackbar_helpers.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  /// Variables
  final _repository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  RxBool isCategoriesLoading = false.obs;

  final _logger = Logger();

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// Function to get all categories $ featured categories from firebase
  Future<void> fetchCategories() async {
    try {

      // start loading
      isCategoriesLoading.value = true;

      // fetch Categories
      List <CategoryModel> categories = await _repository.getAllCategories();
      // _logger.d("Categories: $categories");
      allCategories.assignAll(categories);

      // get featured Categories
      featuredCategories.assignAll(categories.where((category) => category.isFeatured && category.parentId.isEmpty));

    } catch(e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    } finally{
      isCategoriesLoading.value = false;
    }
  }

  /// Function to Get Category Products
  Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 4}) async {
       try {

         final products = ProductRepository.instance.getProductsForCategory(categoryId: categoryId, limit: limit);

         return products;

       } catch (e) {
         USnackBarHelpers.errorSnackBar(title: "Failed!", message: e.toString());
         return [];
       }
  }

  /// Function to Get Sub Categories of selected Category
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {

      final subCategories = await _repository.getSubCategories(categoryId);
      return subCategories;

    } catch(e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
      return [];
    }
  }



}