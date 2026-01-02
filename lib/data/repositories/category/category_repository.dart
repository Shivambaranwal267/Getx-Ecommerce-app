import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dio;
import 'package:ecommerce/data/services/cloudinary_services.dart';
import 'package:ecommerce/features/shop/models/brand_category_model.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/features/shop/models/product_category_model.dart';
import 'package:ecommerce/utils/constants/keys.dart';
import 'package:ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());


  final _logger = Logger();

  /// [Upload] - Function to upload of brand categories
  Future<void> uploadBrandCategory(List<BrandCategoryModel> brandCategories) async {
    try {
      for(final brandCategory in brandCategories) {
        await _db.collection(UKeys.brandCategoryCollection).doc().set(brandCategory.toJson());
      }

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


  /// [Upload] - Function to upload of Product categories
  Future<void> uploadProductCategory(List<ProductCategoryModel> productCategories) async {
    try {
      for(final productCategory in productCategories) {
        await _db.collection(UKeys.productCategoryCollection).doc().set(productCategory.toJson());
        _logger.i('Uploaded: ${productCategory.productId}');
      }


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



  /// [UploadCategory] - Function to upload list of categories
  Future<void> uploadCategories(List<CategoryModel> categories) async {
    try {
      for (final category in categories) {
        File image = await UHelperFunctions.assetToFile(category.image);

        dio.Response response = await _cloudinaryServices.uploadImage(image, UKeys.categoryFolder);

        if (response.statusCode == 200) {
          category.image = response.data['url'];
        }

        await _db.collection(UKeys.categoryCollection).doc(category.id).set(category.toJson());


        // _logger.i('Category Uploaded:  ${category.name}');


      }
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

  /// [FetchCategory] - Function to fetch list of categories
 //   Future<List<CategoryModel>> getAllCategories() async {
 //    try{
 //
 //    final query = await _db.collection(UKeys.categoryCollection).get();
 //
 //    if(query.docs.isNotEmpty) {
 //      List<CategoryModel> categories = query.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
 //      _logger.i(categories.map((e) => e.toJson()).toList());
 //      return categories;
 //    }
 //
 //    return [];
 //
 //   } on FirebaseException catch (e) {
 //      throw UFirebaseException(e.code).message;
 //    } on FormatException catch (_) {
 //      throw UFormatException();
 //    } on PlatformException catch (e) {
 //      throw UPlatformException(e.code).message;
 //    } catch (e) {
 //      throw 'Something went wrong, Please try again';
 //    }
 // }
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      // _logger.t("Fetching all categories...");

      final query = await _db.collection(UKeys.categoryCollection).get();

      if (query.docs.isNotEmpty) {
        List<CategoryModel> categories =
        query.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();

        // _logger.i("Fetched ${categories.length} categories");

        // Pretty JSON log
        // _logger.d(categories.map((e) => e.toJson()).toList());

        return categories;
      }

      // _logger.w("No categories found!");
      return [];

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


  /// [FetchSubCategory] - Function to fetch list of sub categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {

      final query = await _db.collection(UKeys.categoryCollection).where('parentId', isEqualTo: categoryId).get();

      if (query.docs.isNotEmpty) {
        List<CategoryModel> categories = query.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
        return categories;
      }

      return [];

    }  on FirebaseException catch (e) {
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
