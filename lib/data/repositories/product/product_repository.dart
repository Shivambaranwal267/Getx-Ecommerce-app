import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dio;
import 'package:ecommerce/data/services/cloudinary_services.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/keys.dart';
import 'package:ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();



  /// Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  final _logger = Logger();

  /// [Upload] - Function to upload list of products
  Future<void> uploadProducts(List<ProductModel> products) async {
    try {
      for(ProductModel product in products) {

        final Map<String, String> uploadedImageMap = {};

        // upload thumbnail to cloudinary
        File thumbnailFile = await UHelperFunctions.assetToFile(product.thumbnail);
        dio.Response response = await _cloudinaryServices.uploadImage(thumbnailFile, UKeys.productsFolder);

        if(response.statusCode == 200) {
           String url = response.data['url'];
           uploadedImageMap[product.thumbnail] = url;
           product.thumbnail= url;
        }

        // upload product images
        if(product.images != null && product.images!.isNotEmpty) {
          List<String> imageUrls = [];

          for(String image in product.images!) {
            // upload image to cloudinary
            File imageFile = await UHelperFunctions.assetToFile(image);
            dio.Response response = await _cloudinaryServices.uploadImage(imageFile, UKeys.productsFolder);
            if(response.statusCode == 200) {
              imageUrls.add(response.data['url']);
            }
          }

          /// upload product variation images
          if (product.productVariations != null && product.productVariations!.isNotEmpty) {

            for(int  i= 0; i < product.images!.length; i++) {
              uploadedImageMap[product.images![i]] = imageUrls[i];
            }

            for (final variation in product.productVariations!) {
              final match = uploadedImageMap.entries.firstWhere(
                    (entry) => entry.key == variation.image,
                orElse: () => const MapEntry('', ''),
              );

              if (match.key.isNotEmpty) {
                variation.image =match.value;
              }
            }
          }

          // assign image urls to product
          product.images!.clear();
          product.images!.assignAll(imageUrls);
        }

        // upload product to Firestore
        await _db.collection(UKeys.productsCollection).doc(product.id).set(product.toJson());

        _logger.i('Product ${product.id} uploaded Successfully');
      }

    }on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  /// [Fetch] - Function to fetch list of products from firebase
  Future<List<ProductModel>> fetchFeaturedProducts() async {
    try {
     final query = await _db.collection(UKeys.productsCollection).where('isFeatured', isEqualTo: true).limit(4).get();

     if(query.docs.isNotEmpty) {
       List<ProductModel> products = query.docs.map((document) => ProductModel.fromSnapshot(document)).toList();
       return products;
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

  /// [Fetch] - Function to fetch list of  All-Products from firebase
  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      final query = await _db.collection(UKeys.productsCollection).where('isFeatured', isEqualTo: true).get();

      if(query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs.map((document) => ProductModel.fromSnapshot(document)).toList();
        return products;
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

  /// [Fetch] - Function to fetch list of  All-Products from firebase
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapShot = await query.get();

      if(querySnapShot.docs.isNotEmpty) {
        List<ProductModel> products = querySnapShot.docs.map((document) => ProductModel.fromQuerySnapshot(document)).toList();
        return products;
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

  /// [Fetch] - Function to fetch all list of brands specific products from firebase
  Future<List<ProductModel>> getProductsForBrand({required String brandId, int limit = -1}) async {
    try {

      final query = limit == -1
          ? await _db.collection(UKeys.productsCollection).where('brand.id', isEqualTo: brandId).get()
          : await _db.collection(UKeys.productsCollection).where('brand.id', isEqualTo: brandId).limit(limit).get();

      if(query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs.map((document) => ProductModel.fromSnapshot(document)).toList();
        return products;
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

  /// [Fetch] - Function to fetch all list of Category specific products from firebase
  Future<List<ProductModel>> getProductsForCategory({required String categoryId, int limit = -1}) async {
    try {

      final productCategoryQuery = limit == -1
          ? await _db.collection(UKeys.productCategoryCollection).where('categoryId', isEqualTo: categoryId).get()
          : await _db.collection(UKeys.productCategoryCollection).where('categoryId', isEqualTo: categoryId).limit(limit).get();

      List<String> productIds = productCategoryQuery.docs.map((doc) => doc['productId'] as String).toList();

      final productQuery = await _db.collection(UKeys.productsCollection).where(FieldPath.documentId, whereIn:productIds).get();
      
      List<ProductModel> products = productQuery.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();

      return products;

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

  /// [Fetch] - Function to fetch list of favourite products from firebase
  Future<List<ProductModel>> getFavouriteProducts(List<String> productsIds) async {
    try {
      final query = await _db.collection(UKeys.productsCollection).where(FieldPath.documentId, whereIn: productsIds).get();

      if(query.docs.isNotEmpty) {
        List<ProductModel> products = query.docs.map((document) => ProductModel.fromSnapshot(document)).toList();
        return products;
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



}