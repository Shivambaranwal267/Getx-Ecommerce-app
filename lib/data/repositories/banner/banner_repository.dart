import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dio;
import 'package:ecommerce/data/services/cloudinary_services.dart';
import 'package:ecommerce/features/shop/models/banners_model.dart';
import 'package:ecommerce/utils/constants/keys.dart';
import 'package:ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  final _logger = Logger();

  /// [UploadBanners] - Function to upload list of banners
  Future<void> uploadBanners(List<BannerModel> banners) async {
    try {

      for(final banner in banners) {
        // convert assetPath to FIle
       File image = await UHelperFunctions.assetToFile(banner.imageUrl);

       // upload banner image to cloudinary
       dio.Response response = await  _cloudinaryServices.uploadImage(image, UKeys.bannersFolder);

       // if image is found in cloudinary
       if(response.statusCode == 200) {
         banner.imageUrl = response.data['url'];
       }

       await _db.collection(UKeys.bannerCollection).doc().set(banner.toJson());

       // _logger.i('Banner Uploaded:  ${banner.targetScreen}');
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

  /// [FetchBanners] - Function to get all active list of banners
  Future<List<BannerModel>> fetchActiveBanners() async {
    try {
      // _logger.t("Fetching all active banners...");
     final query =  await _db.collection(UKeys.bannerCollection).where('active', isEqualTo: true).get();
     if(query.docs.isNotEmpty) {
       List<BannerModel> banners =  query.docs.map((document) => BannerModel.fromDocument(document)).toList();
       // _logger.i("Fetched ${banners.length} Active Banners");
       // Pretty JSON log
       // _logger.d(banners.map((e) => e.toJson()).toList());
       return banners;
     }
      _logger.w("No Banners found!");
     return [];


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

}
