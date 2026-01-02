import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {

  /// Widget Flutter Binding
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// Widget Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// Storage
  await GetStorage.init();

  /// Firebase Initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,).then((value) {
    Get.put(AuthenticationRepository());
  });

  /// Portrait Up the Device
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}
