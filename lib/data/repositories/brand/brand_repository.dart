import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dio;
import 'package:ecommerce/data/services/cloudinary_services.dart';
import 'package:ecommerce/features/shop/models/brand_category_model.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:ecommerce/utils/constants/keys.dart';
import 'package:ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());


  final _logger = Logger();


  /// [Upload] - Function to upload all brands
  Future<void> uploadBrands(List<BrandModel> brands) async {
    try {
      for(BrandModel brand in brands) {

        _logger.i("Uploading brand: ${brand.name}");



        // convert asset path to file
        File brandImage = await UHelperFunctions.assetToFile(brand.image);

        // upload brand image to cloudinary
        dio.Response response = await _cloudinaryServices.uploadImage(brandImage, UKeys.brandsFolder);



        if (response.statusCode == 200) {
          brand.image = response.data['url'];
        } else {
          throw "Cloudinary upload failed: ${response.statusCode}";
        }



        // store data to firebase fireStore
        await _db.collection(UKeys.brandsCollection).doc(brand.id).set(brand.toJson());


        _logger.i('Brand ${brand.name} uploaded Successfully');
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

  // Future<void> uploadBrands(List<BrandModel> brands) async {
  //   try {
  //     for (BrandModel brand in brands) {
  //       _logger.i("Uploading brand: ${brand.name}");
  //
  //       String imageUrl;
  //
  //       if (brand.image.startsWith("http")) {
  //         _logger.i("Image already uploaded. Skipping upload for: ${brand.image}");
  //         imageUrl = brand.image;  // Preserve existing URL
  //       } else {
  //         File brandImage = await UHelperFunctions.assetToFile(brand.image);
  //         dio.Response response = await _cloudinaryServices.uploadImage(brandImage, UKeys.brandsFolder);
  //
  //         if (response.statusCode == 200 && response.data['url'] != null) {
  //           imageUrl = response.data['url'];
  //         } else {
  //           throw "Cloudinary upload failed: Invalid response";
  //         }
  //       }
  //
  //       brand.image = imageUrl;
  //
  //       await _db.collection(UKeys.brandsCollection).doc(brand.id).set(brand.toJson());
  //       _logger.i('Brand ${brand.name} processed successfully');
  //     }
  //   }on FirebaseException catch (e) {
  //     throw UFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw UFormatException();
  //   } on PlatformException catch (e) {
  //     throw UPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong, Please try again';
  //   }
  // }



  /// [Fetch] - Function to get all brands
  Future<List<BrandModel>> fetchBrands() async {
    try {
     final query =  await _db.collection(UKeys.brandsCollection).get();

     if(query.docs.isNotEmpty) {
       List<BrandModel> brands = query.docs.map((document) => BrandModel.fromSnapshot(document)).toList();
       return brands;
     }

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


  /// [Fetch] - Function to get category specific brands
  Future<List<BrandModel>> fetchBrandsForCategory(String categoryId) async {
    try {
      // Query to get all document where categoryIds matches the provided categoryId
      final brandCategoryQuery = await _db.collection(UKeys.brandCategoryCollection).where('categoryId', isEqualTo: categoryId).get();

      // Convert document to models
      List<BrandCategoryModel> brandCategories = brandCategoryQuery.docs.map((doc) => BrandCategoryModel.fromSnapshot((doc))).toList();

      // Extract brandIds from BrandCategoryModels
      List<String> brandIds = brandCategories.map((brandCategory) => brandCategory.brandId).toList();

      // Query to get brands based on brandIds
      final brandQuery = await _db.collection(UKeys.brandsCollection).where(FieldPath.documentId, whereIn: brandIds).limit(2).get();

      // convert doc to model
      List<BrandModel> brands  = brandQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

      return brands;

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