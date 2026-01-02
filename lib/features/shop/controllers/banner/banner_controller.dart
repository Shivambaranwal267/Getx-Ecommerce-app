import 'package:carousel_slider/carousel_controller.dart';
import 'package:ecommerce/data/repositories/banner/banner_repository.dart';
import 'package:ecommerce/features/shop/models/banners_model.dart';
import 'package:ecommerce/utils/popups/snackbar_helpers.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  /// Variables
  final _repository = Get.put(BannerRepository());
  final carouselController = CarouselSliderController();
  RxInt currentIndex = 0.obs;
  RxList<BannerModel> banners = <BannerModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }


  /// On Carousel Page Changed
  void onPageChanged(int index) {
    currentIndex.value = index;
  }


  // fetch all banner
  Future<void> fetchBanners() async {
    try {

      // start loading
      isLoading.value = true;

      List<BannerModel> activeBanners = await _repository.fetchActiveBanners();
      banners.assignAll(activeBanners);


    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }


}

